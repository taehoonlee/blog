---
title: "Data exchange among MATLAB, python, and C"
categories: [tech, matlab]
tags: [data-exchange-MATLAB-C, data-exchange-MATLAB-python, data-exchange-python-C]
---

데이터를 이리저리 옮기는 일은 다양한 환경에서 프로그래밍을 하기 위해 반드시 필요하지만, 몇 줄 안 되는 코드임에도 불구하고 작성하기 꽤 귀찮은 편이다. 개인적으로는 윈도우에서 MATLAB에서 작업하다가, 엄청난 속도를 필요로 할 때에는 서버로 옮겨서 python+CUDA로 작업하다가, 또 직접 CUDA 구현이 필요할 때에는 C에서 데이터를 불러와서 테스트하기도 한다. 바이너리로 데이터 파일을 작성하면 쉽게 쉽게 옮길 수 있는데, 아래 코드들을 살펴보자.

MATLAB에서 변수 X를 파일로 저장할 때 보통

```matlab
save(['X.txt','X','-ascii');
```

와 같은 명령을 사용한다. X.txt는 메모장으로 열어서 숫자를 직접 확인할 수 있는 아스키 코드로 된 파일이다. 하지만 아스키 코드로 저장하면 C에서 load하는 코드를 (사실 몇 줄 차이일 뿐이지만..) 작성하기 귀찮아진다. 심지어 double형 변수일 경우에는 막대한 파일 용량을 감내해야 한다. 아래와 같이 MATLAB에서 변수 X를 바이너리로 저장해보자.

```matlab
P = 1000;
N = 100;
X = rand(P, N);
f = fopen('X.txt', 'w');
fwrite(f, X, 'double');
fclose(f);
```

이렇게 저장한 X.txt는 이제 메모장으로 열어도 숫자를 확인할 수 없는 대신에, python과 C에서 단 한 줄로 read가능하다. 아래 예제 코드를 살펴보자.

Python에서는 numpy.fromfile을 호출하면 되고,
```python
import numpy as np
P = 1000
N = 100
f = open("X.txt", "rb")
X = np.fromfile(f, dtype=np.double).reshape(N, P)
f.close()
```

C에서는 fread를 사용하면 된다!
```c
int P = 1000;
int N = 100;
FILE *f = fopen("X.txt", "rb");
double *X = (double *) malloc ( P * N * sizeof(double) );
fread(X, sizeof(double), (size_t) N * P, f);
fclose(f);
```
이 때, MATLAB은 column-ordered type인 반면에 python은 row-ordered type이므로 (P x N) matrix는 (N X P) matrix로 불러와야 값들의 정확한 배열을 유지할 수 있다.

***요약하면***, 아래와 같은 코드를 사용하면 된다.
```matlab
X = reshape(fread(f, 'double'), P, N); % read in MATLAB
fwrite(f, X, 'double'); % write in MATLAB
```
```python
X = np.fromfile(f, dtype=np.double).reshape(N, P) # read in python
X.tofile(f) # write in python
```
```c
fread(X, sizeof(double), (size_t) N * P, f); // read in C
fwrite(X, sizeof(double), (size_t) N * P, f); // write in C
```
