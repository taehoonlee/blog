---
title: "Deep learning MATLAB toolbox"
categories: [tech, matlab]
tags: [Deep-Learning, Deep-Learning-MATLAB, Deep-Learning-Toolbox, Easy-Deep-Learning-MATLAB]
---

Deep learning toolbox를 찾다보면 python이 정말 대세임을 알 수 있다. 현재 python+CUDA의 조합으로 cuda-convnet2, caffe, theano 등 여러가지 패키지들이 각자의 위용을 뽐내며 ML community에 자리를 잡아가고 있다. 간단히 요약하면 아래와 같다.

- Cuda-convnet2
  - [https://code.google.com/p/cuda-convnet2/](https://code.google.com/p/cuda-convnet2/)
  - Maintained by Alex Krizhevsky
- Caffe
  - [https://github.com/BVLC/caffe/](https://github.com/BVLC/caffe/)
  - DIY Deep Learning
  - Maintained by Berkeley Vision and Learning Center
- Theano
  - [https://github.com/Theano/](https://github.com/Theano/)
  - General library to evaluate mathematical expressions
  - Maintained by (mainly) LISA Lab.

3가지 모두 GPU를 이용한 빠른 속도와 사용자 편의성을 강조하면서, 서로 주도권을 넘겨주지 않으려고 열심히 유지보수를 하는 것 같다. 위 3가지를 포함하여 딥러닝 패키지를 7-8개 정도 사용해보면서 개인적으로 가장 아쉬웠던 점은 보다 더 user friendly한 interface가 없을까 하는 점이었다.

다양한 model parameters들을 customize하기 쉽게 만들어 놓은 것은 큰 장점인 동시에 단점이 될 수도 있다. 아무래도 이런 자유도를 만끽할 수 있는 사람들은 풍부한 경험을 가진 박사 고년차 이상의 엔지니어들이 대부분이고, 초심자들은 방대한 configuration file과 example codes들을 접하고 어디부터 손을 대야 할지 난감해 하기도 한다. 특히, 갓 입문한 사람들은 caffe와 theano사용법 자체를 익히는 데에 많은 시간을 할애 하다가 deep learning에서 outfocusing되는 경우도 종종 발생한다. 딥러닝을 연구하면서 이런 아쉬운 점을 꼭 해결하고 싶은 욕구가 생기게 되었고, 얼마 전 나 같이 MATLAB 편한 사람들을 위해서 작업 중인 코드를 공개하였다.

[https://github.com/taehoonlee/easyDL/](https://github.com/taehoonlee/easyDL/)

![w660p](https://iamtaehoon.files.wordpress.com/2015/08/ecbaa1ecb298.png)

현재는 feed-forward deep neural networks과 간단한 autoencoders를 지원하는데 차츰 기능을 늘려나갈 계획이다. Readme의 example codes에서 볼 수 있듯이, 정말 딥러닝에 대해 아무것도 모르는 사람도 쉽게 tweak하여 돌려볼 수 있도록 구현하는 것이 목표였다. 아무쪼록 사람들이 많이 찾는 툴박스가 되었으면 좋겠다!
