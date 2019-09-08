---
title: "MATLAB의 그림을 R의 ggplot처럼 아름답게 만들기"
categories: [tech, matlab]
tags: [data-visualization, ggplot, MATLAB-simple-figure, tfigure]
---

내가 MATLAB을 처음에 선택한 이유는 예뻐서이다. 특히 GUI는 다른 스크립트 언어와는 비교할 수 없는 넘사벽이며, 윈도우 환경에서 나가고 싶지 않은 나 같은 나약한 엔지니어에게 굉장한 매력 중 하나인 것 같다. 그에 비해서, 결과로 나오는 그래프들을 경험해보면 가끔 아쉬운 느낌이 들 때도 있다. GUI에 공들인 만큼 기본적인 그래프 함수들에는 신경을 덜 쓴 것 같다는 생각이 든다. 일단 프로그램 골격을 탄탄하게 잡아 놓으면, 많은 써드파티와 개인 개발자들이 자발적으로 라이브러리를 만들겠지 라는 기대를 했을지도 모르겠다.

나는 아름다운 그래프 만들기를 너무 좋아해서, R의 그래프를 보면서 언젠가는 MATLAB으로도 저런 그래프를 그리고 말리라 라는 다짐을 하곤 했다. 특히 ggplot의 색상이 너무나도 탐이 났었다. 마침 연구 진행이 잠시 정체기를 맞아서, 바람 쐬는 기분으로 나의 덕력을 발휘해 보았다.

함수는 총 4개이며, github에 공유 해놓았다. 이번 기회에 계정 만든 이후 처음으로 commit도 해보았다. 페이지([https://github.com/taehoonlee/tfigure](https://github.com/taehoonlee/tfigure))에 가서 zip 파일로 다운 받아도 되고 아래와 같이 커맨드라인에서 직접 받을 수도 있다.

```
git clone https://github.com/taehoonlee/tfigure.git
```

먼저 ggPalette 함수부터 살펴보자. 내가 제일 하고 싶었던 일은 아래와 같은 ggplot의 palette를 재현하는 일이었다.

![ggplot의 기본 팔레트](https://iamtaehoon.files.wordpress.com/2015/03/ggplot2_scale_hue_colors.png)

*ggplot의 기본 팔레트 (이미지 출처: [http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/](http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/))*

매뉴얼 페이지를 읽어보면 HCL color circle에서 동일한 간격을 유지하여 색을 선택하라고 되어있다. 예를 들어 색을 3개 보여준다면, 인접한 hue(H)값의 차이가 120도를 유지하도록 설정해준다. 그리고 hue(H)의 bias값과 chroma(C), lightness(L)값의 선택 또한 중요한 포인트 인데, 매뉴얼에 나와있지 않아서 가벼운 노ㅋ가ㅋ다를 통해 알아 냈다. 최종적으로 위의 palette를 재현하려면 H=15+360/N, C=65, L=100으로 지정하면 된다. 잘 와 닿지 않는다면, 일단 아래의 코드를 돌려보고 ggPalette 함수 내부를 조금만 들여다 보면 될 것이다. HCL값을 RGB값으로 변환해주기 위해서 hcl2rgb 함수([출처](https://github.com/nickjhughes/hclmat/blob/master/hcl2rgb.m))를 받아서 수정하였다.

```matlab
N = 5;
image(1:N);
colormap(ggPalette(N));
```

![ggPalette 실행 예](https://iamtaehoon.files.wordpress.com/2015/03/untitled0.png)

*ggPalette 실행 예*

위와 같은 그림을 MATLAB에서 확인했다면, ggplot의 palette를 사용할 준비가 된 것이다. 이 색상들을 가지고 ggplot을 최대한 비슷하게 따라 해보자. 총 3개의 그래프 함수를 작성하였다: tplot, tbar, tboxplot. 각각은 built-in plot, bar, boxplot 함수들의 대체재라고 할 수 있다. 예제 코드 2개를 준비했다.

```matlab
t = (0:0.1:3) * pi;
X = [0.6 * sin(t); 0.8 * sin(t+5)+0.1; sin(t+10)+0.2];
figure;
subplot(1,3,1), tplot(t, X);
subplot(1,3,2), tbar(sum(abs(X),2));
subplot(1,3,3), tboxplot(X');
```

![tfigure 실행 예 1: 3가지 색상 활용](https://iamtaehoon.files.wordpress.com/2015/03/untitled1.png)

*tfigure 실행 예 1: 3가지 색상 활용*

3가지 색상을 활용하면 위와 같은 그림을 얻을 수 있다. 그리고 아래의 예제는 10가지 색상이 들어간 그림이다.

```matlab
t = 1:100
X = chi2rnd(1,t(end),10);
figure;
subplot(1,3,1), tplot(t, X);
subplot(1,3,2), tbar(sum(X,1));
subplot(1,3,3), tboxplot(X);
```

![tfigure 실행 예 2: 10가지 색상 활용](https://iamtaehoon.files.wordpress.com/2015/03/untitled2.png)

*tfigure 실행 예 2: 10가지 색상 활용*

MATLAB의 그림을 예쁘게 만들어 놓으니 심신이 한결 안정된 느낌이다. 색상이 아주 마음에 든다. 사실 ggplot은 회색바탕이 기본이지만, 출력물을 생각했을 때 최선의 선택은 아닌 것 같다. 나는 무난하게 하얀색 바탕으로 설정해 놓았고, 여백이나 폰트 같은 기타 자세한 사항들은 코드를 직접 확인하면 쉽게 찾아볼 수 있다. 언젠가는 사람들이 많이 찾는 코드가 되었으면 좋겠다.
