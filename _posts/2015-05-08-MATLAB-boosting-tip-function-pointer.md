---
title: "MATLAB boosting tip: function pointer"
categories: [tech, matlab]
tags: [function-pointer]
---

다른 많은 언어들과 마찬가지로, MATLAB에도 함수 포인터가 존재한다. 잘 사용하면 아주 유용한 개념인데도 불구하고, 여러 public codes를 받아보면 실제로 사용되고 있는 경우는 많이 접하기 힘든 것 같다. 보통 언어를 배울 때, 골격이 되는 문법 위주로 강의가 진행되다 보니, 아무래도 밑반찬 격인 function pointer에 대해서는 존재 정도만 잠시 들어보고 종강을 하게 되는 것 같다. 그래서 대부분의 사람들은 syntax를 추가적으로 배워서 구현하는 것 보다도, 이미 익숙한 기본 문법들로 코딩하는 것을 조금 더 선호하는 것이 아닌가 생각한다. 그런데, MATLAB function pointer는 아주 쉽다!!! 심지어 빠르다!! 활용 가능한 상황이라면 무조건 권하고 싶다.

가끔씩 한 줄 짜리 함수를 접하게 된다. 아래와 같은 sigmoid함수가 대표적이다.
```matlab
function y = sigmoid(x)
    y = 1 ./ ( 1 + exp(-x) );
```
그리고 메인 스크립트에서 `Y = sigmoid(W*X + b)`를 계산하기 위해서 아래와 같이 외부 함수를 호출하는 코드를 작성했다고 하자.
```matlab
Y = sigmoid( bsxfun(@plus, W * X, b ) );
```

일단 함수 안에 함수가 있어서 복잡해 보인다. 물론 코드 가독성만을 위한다면 안쪽 함수를 밖으로 빼내어 두 줄로 작성하면 되지만, 이런 상황에는 아래와 같이 function pointer를 사용해보자.
```matlab
getActivations = @(a,b,c) 1 ./ ( 1 + exp(-bsxfun(@plus, a * b, c )) );
Y = getActivations(W,X,b);
```
외부 함수를 따로 작성하는 것이 아니라, 메인 스크립트 안에 마치 변수처럼 함수를 정의하는 것이다. 문법이 아주 쉽다!! getActivations 함수는 3개의 arguments (a,b,c) 를 받겠다는 뜻이고, @(a,b,c) 뒤에는 실제 수행될 문장을 적어주면 끝이다. 이렇게 변환해주면 코드 가독성도 향상되고, 외부 함수 호출 대비 수행 시간 또한 단축시킬 수 있다.

아래와 같이 수행 시간 테스트를 해보자. 세 개의 블럭은 각각 외부 함수 호출하는 경우, function pointer 사용하는 경우, inline으로 때워버린 경우이다. 동일한 크기의 변수들에 대해 10000번 계산하는 시간을 측정하였고, 각기 다른 방법의 효과를 뚜렷하게 보기 위해서 데이터가 caching 되지 않도록 매번 새로운 데이터로 연산을 수행하였다.
```matlab
getActivations = @(a,b,c) 1 ./ ( 1 + exp(-bsxfun(@plus, a * b, c )) );

runtime = 0;
for i = 1:10000
    W = rand(100,784);
    X = rand(784,1000);
    b = rand(100,1);
    tic;Y = sigmoid( bsxfun(@plus, W * X, b ) );
    runtime = runtime + toc;
end
disp(runtime)

runtime = 0;
for i = 1:10000
    W = rand(100,784);
    X = rand(784,1000);
    b = rand(100,1);
    tic;Y = getActivations(W,X,b);
    runtime = runtime + toc;
end
disp(runtime)

runtime = 0;
for i = 1:10000
    W = rand(100,784);
    X = rand(784,1000);
    b = rand(100,1);
    tic;Y = 1 ./ ( 1 + exp(-bsxfun(@plus, W * X, b )) );
    runtime = runtime + toc;
end
disp(runtime)
```
개인 PC (i5-3570K@3.4GHz) 에서의 수행시간은 각각

- 외부 함수 호출: 39.5269초
- 함수 포인터 호출: 34.8993초
- 함수 호출 제거: 34.4462초

와 같았다. 함수 포인터를 호출하면 외부 함수 호출과 비교했을 때 콜스택이 하나 덜 생성되므로 시간을 줄일 수 있다. 결과적으로는 함수 호출이 없는 경우와 동일한 수행 시간을 얻을 수 있으며 가독성 또한 증가시킬 수 있다. 그리고 함수를 변경해 가면서 for-loop을 수행하는 경우에도 (예) pre-processing method 바꿔가며 동일한 classifier 테스트하기), function pointer로 가독성 좋고 빠른 코드를 작성할 수 있다!
