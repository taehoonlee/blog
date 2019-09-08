---
title: "Spectral variation in CNN"
categories: [tech, machine-learning]
tags: [CNN, Spectral-variation]
mathjax: true
---

연구실 후배가 *"reduce spectral variation"*라는 표현이 어떤 의미인지 물어보았는데, 처음 듣는 표현이라 시원한 대답을 해주지 못한게 찜찜하여 조금 더 찾아보게 되었다. 일단 원문(Sainath et al., "Deep convolutional neural networks for LVCSR," ICASSP 2013)의 표현은

> Convolutional Neural Networks (CNNs) are an alternative type of neural network that can be used to reduce spectral variations and model spectral correlations which exist in signals.

이었다.

일단 spectrum이라고 하면 보통 음성 신호의 주파수 분포를 말한다. CNN이 spectral variation을 줄여준다는 표현은 내 생각에는 2가지 정도로 해석 가능한 것 같다.

첫째로, CNN의 적용 분야를 음성 신호에만 국한하는 경우에는 그리 어렵지 않게 풀이가 가능하다. 샘플 신호에 기저한 basis spectrum pattern들이 서로 조합되고 노이즈가 추가되어 여러가지 variation들을 가지는 상황에서, 그 variation들에 개의치 않고 주파수 도메인에서의 feature를 잘 학습한다는 것을 의미한다. 조금 더 deep learning 에서 자주 사용되는 용어로 바꿔보자면 invariant feature가 아닌가 생각된다. 영상에서의 translational invariant가 음성에서의 spectral invariant와 비슷한 맥락으로 보여진다.

둘째로, 음성이 아닌 다른 일반적인 신호를 생각해 보자면 input의 spectrum이라는 말은 정확히 와닿지가 않는다. 물론 어떤 신호든 sinusoidal waveforms으로 decomposition은 가능하겠지만, 음성 혹은 영상이 아니라면 그 계수들에 physical meaning을 부여하기는 쉽지 않다. 그렇다면 spectrum을 어떤식으로 해석하는 것이 좋을까. 문헌을 조금 찾아보니 spectral variation이라는 용어가 matrix factorization에도 등장하는 것 같다.

Hermitian matrix $$A$$의 spectrum이라는 것은 eigenvalues의 분포를 뜻한다고 한다. 그렇다면 CNN으로 학습한 a set of feature maps의 covariance matrix를 생성하여 eigenvalue를 측정할 때가, fully-connected networks으로 학습한 a set of weight vectors에서 나온 eigenvalue보다 variation이 더 적다는 의미로 해석이 가능하겠다. 예를 들어, CNN으로 10개의 5x5 feature maps을 학습하고, DBN으로 10개의 hidden nodes를 만들어 100차원을 가지는 weight vectors를 10개 생성했다고 하자. 즉, CNN과 DBN에서 나온 a set of weights $$W_{cnn}, W_{dbn}$$는 아래와 같다.

$$ W_{cnn} \in R^{25 \times 10} $$

$$ W_{dbn} \in R^{100 \times 10} $$

여기 $$W_{cnn}$$와 $$W_{dbn}$$에서 각각 eigenvalues 10개를 계산할 수 있을 것이다. 다양한 noise가 섞이는 상황에서 여러번 a set of eigenvalues를 계산했을 때, $$W_{cnn}$$에서 나온 eigenvalues가 $$W_{dbn}$$에서 나온 것 보다 더 변화가 적다고 할 수 있다. 적은 파라미터 수는 작은 크기의 covariance matrix를 생성하므로 당연한 결과라고 할 수 있다. 10개의 샘플로 100차원의 분포를 추정하는 것보다 25차원의 분포를 추정하는 것이 더 variance가 적은 것이다.

결론은 spectrum은 음성 신호의 주파수 분포를 뜻할 수도 있지만, 행렬에서의 고유값의 분포를 뜻할 수도 있다는 것! 물론 저자들은 전자를 염두해 두고 용어를 사용한 것으로 보이지만, (쓸데없이) 조금 더 공부한 결과 다른 식으로도 해석이 가능했다!
