---
title: "MATLAB boosting tip: bsxfun"
categories: [tech, matlab]
tags: [bsxfun, element-wise-operation]
mathjax: true
---

MATLAB에 유저들에게 for-loops을 최대한 사용하지 않는 것이 컴퓨팅 퍼포먼스를 올려준다는 것은 익히 알려진 팁 중 하나이다. 예를 들어 아래의 the sum of the element-wise products을 구하는 코드를 보자.

```matlab
n = 10000;
a = rand(n, 1);
b = rand(n, 1);
sum = 0;
for i = 1:n
sum = sum + a(i)*b(i);
end
```

전형적인 C 스타일의 코드 작성법이다. 10000개의 elements에 대한 operation을 수행해야 하니 for문을 10000번 돌려서 결과를 얻어야 하는 것은 low-level language에서는 당연하지만, MATLAB과 같은 스크립트 언어에서는 조금 다르다. MATLAB은 처음부터 행렬연산을 위해 태어난 언어이므로, 위의 연산은 벡터의 스칼라곱 $$ \mathbf{a} \cdot \mathbf{b} = \sum_{i=1}^n a_i b_i $$ 으로 이해 해야지만이 최적의 코드를 작성할 수 있다. 즉, 위 코드에서 세 줄로 이루어진 for-loop은 아래의 한 줄과 같은 결과를 낸다.

```matlab
sum = a' * b;
```

실제로, 이렇게 치환을 하는 경우에 내 컴퓨터 (i5-3570K@3.4GHz) 에서 수행시간을 측정해보면 $$ \mathbf{a}, \mathbf{b} \in R^{10000} $$ 일 때 10000번을 반복해서 sum을 구해볼 때 최적화 전후의 차이가 1.9초와 2.1초 정도였다. 만약 1000번의 iteration이 필요한 어떤 알고리즘이 위의 연산을 매 iteration 마다 벡터 100만개에 대해 수행 해야한다면? 저 한 줄의 최적화로 인해 20000초, 약 5시간 반을 이득보게 된다. 음.. 사실 이걸 쓰려던게 아닌데...... 이건 서두에 말한 것 처럼 너무 잘 알려져 있는 팁이다.

위의 팁만큼 중요한데 조금 덜 알려진 것이 있다. 바로, vector-wise operations를 가능하게 하는 bsxfun라는 함수이다. 다시 못난 코드를 작성해보자.

```matlab
n = 10^6;
p = 10^3;
a = rand(p, n);
b = std(a, [], 2);
for i = 1:n
a(:,i) = a(:,i) ./ b;
end
```

행렬 a에는 p차원의 column vector가 n개 존재한다. 모든 벡터에 대해 어떤 특정한 벡터 하나와의 연산을 필요로 하는 경우는 생각보다 자주 발생 한다. 예제와 같이 표준 편차 혹은 min,max 등으로 나누어 주는 normalize가 필요할 때, 평균을 빼는 centralize를 수행해야 할 때, deep learning에서 특히 많이 사용되는데 벡터마다 bias값을 더해줄 때 등이 있다. 이럴 때에는, bsxfun이라는 MATLAB built-in 함수를 사용해서 최적화가 가능하다. 위와 같은 for-loops을 만난다면 반드시 아래처럼 바꾸어주자!

```matlab
a = bsxfun(@rdivide, a, b);
```

벡터끼리 element-wise multiplication을 하고 싶다면 @rdivide를 @times로 변경하면 되고, 모든 벡터에 대해서 하나의 벡터를 더하거나 빼고 싶다면 @plus나 @minus로 바꾸어 주면 된다. 다른 옵션들은 help bsxfun으로 확인 가능하다. 실제 성능 차이를 살펴보면, 위의 코드를 1번 수행할 때, 4.3초 걸리는 못난 코드를 1.2초로 줄일 수 있다. 이에 대한 나비 효과는 긴 말이 필요 없을 것 이다.

다음 MATLAB 포스팅은 MATLAB에서 C 코드를 수행시키는 인터페이스인 mex에 관해 설명 할 예정이다.
