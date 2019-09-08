---
title: "OS X El Capitan에서 keras, tensorflow 설치하기"
categories: [tech, unix]
tags: [Deep-Learning-Toolbox, El-Capitan, Keras-Install, OS-X, Tensorflow-Install]
---

우분투 서버를 벗어나 신형 맥북프로에서 작업을 하게 되었다. Python package들을 설치 하다가 생각지도 못한 에러에 부딪혔는데, sudo 권한으로 설치를 하는데도 아래와 같은 permission error가 발생하는 것이었다.

```
$ sudo pip install jupyter
OSError: [Errno 1] Operation not permitted: '/xxx/System/Library/Frameworks/Python.framework/Versions/2.7/Extras/lib/python/xxx'
```

파일 권한도 문제 없고 sudo인데 왠 permission error인가 해서 간만에 열심히 구글링을 했다. 문제는 OS X El Capitan 부터 생긴 [System Integrity Protection](https://en.wikipedia.org/wiki/System_Integrity_Protection)라는 신기한 정책이었다. Python package는 기본 셋팅이라면 `/System`아래에 우선적으로 설치를 시도하게 되는데, `/System`을 포함한 몇 개의 폴더들이 운영체제 차원에서 접근이 금지 되어 에러가 발생하는 것 이었다. 이를 해결하기 위해서는 아래와 같은 방법으로 System Integrity Protection 을 끄면 된다.

- 부팅 시 사과 로고에서 command+R 키를 눌러 복구 모드로 부팅
- Utilities에서 Terminal을 키고 `csrutil disable` 입력 후 재부팅

이렇게 `/System`폴더의 권한을 풀어놓으면 특별한 문제는 없지만, 조금 더 깔끔한 셋팅을 원한다면 아래 사항들을 추가 적용하면 좋을 것 같다. 여기부터는 El Capitan 뿐 아니라 OS X 에서 모두 해당되는 사항이다. Package version conflict을 막는 방법이다. 터미널에서 아래와 같은 명령어를 입력하면 python package 폴더 리스트를 볼 수 있다.

```
$ python -c "import site;print site.getsitepackages();"
['/System/Library/Frameworks/Python.framework/Versions/2.7/Extras/lib/python',
'/Library/Python/2.7/site-packages']
```

El Capitan에서 아무 것도 건드리지 않았다면 위와 같이 나올 것이고, 아마도 다른 OS X에서도 마찬가지 일 것 같다. Package import 시 `/System/.../python`과, `/Library/.../site-packages` 두 군데에서 불러오고 당연히 첫번째 폴더를 우선적으로 체크하게 된다. 그런데 가끔 개별 패키지 설치 스크립트 안에 있는 명령 때문에 순서가 뒤바뀌는 경우가 있어서, 패키지 관리자 `pip`로 설치해도 첫번째 건너뛰고 두번째 폴더에 설치되는 경우가 있다. 이러다 보면 두 군데 다른 버전이 설치되고 import시 conflict이 나는 경우가 생기는데, 아래를 참고하시어 폴더 하나만 남겨놓는 것이 깔끔하다고 생각된다.

- `/System` 밑에 있는 `numpy`와 `scipy`를 삭제한다.

```
$ sudo rm -rf /System/Library/Frameworks/Python.framework/Versions/2.7/Extras/lib/python/numpy
$ sudo rm -rf /System/Library/Frameworks/Python.framework/Versions/2.7/Extras/lib/python/scipy
```

- 기본 경로 설정하는 스크립트를 변경해서 `/Library/Python/2.7/site-packages` 하나만 남긴다 (`getsitepackages`함수 찾아서 해당 부분 아래와 같이 주석처리).

```
$ sudo vi /System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site.py
```

```python
def getsitepackages():
...
#elif sys.platform == 'darwin' and prefix == sys.prefix:
# sitepackages.append(os.path.join(prefix, "Extras", "lib", "python"))
#elif os.sep == '/':
# sitepackages.append(os.path.join(prefix, "lib",
# "python" + sys.version[:3],
# "site-packages"))
# sitepackages.append(os.path.join(prefix, "lib", "site-python"))
#else:
# sitepackages.append(prefix)
# sitepackages.append(os.path.join(prefix, "lib", "site-packages"))
```

- 이제 python package 폴더 리스트를 확인하면 하나만 나온다.

```
$ python -c "import site;print site.getsitepackages();"
['/Library/Python/2.7/site-packages']
```

- 이제 아래처럼 마음껏 설치 하셔도 conflict 안 날 거에요!

```
$ pip install --upgrade numpy scipy keras jupyter
$ pip install --upgrade https://storage.googleapis.com/tensorflow/mac/tensorflow-0.8.0-py2-none-any.whl
$ python -c "import numpy, scipy, keras, tensorflow"
```
