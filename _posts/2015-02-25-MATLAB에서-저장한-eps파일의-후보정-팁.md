---
title: "MATLAB에서 저장한 eps파일의 후보정 팁"
categories: [tech, matlab]
tags: [MATLAB-Illustrator, MATLAB-figure]
---

한 때 이 문제로 고생 좀 했었다. TeX를 사용하여 논문을 컴파일하기 위해 보통 MATLAB에서 나온 figure를 eps로 저장한다. 가끔씩 이 파일을 그대로 사용하지 않고, 여러 그림을 조합하거나 component의 배치를 더 이쁘게 만들기 위해서 Illustrator로 편집을 하는 경우가 있다. 그런데, 매트랩으로 나온 eps를 일러에서 열어서 다시 저장하면 색상이 깨지게 된다. 이 때에는 아래와 같이 RGB로 색상 모드를 통일하면 된다.

- RGB로 열기

매트랩에서 저장한 eps를 일러에서 열면 아래와 같은 걸 물어본다. RGB를 선택하자.

![캡처](https://iamtaehoon.files.wordpress.com/2015/02/ecbaa1ecb298.png)

- RGB로 저장하기

편집을 완료하고, 다른 이름으로 저장에서 eps로 저장을 하면 아래와 같은 옵션창이 나타난다. 여기에서 CMYK 포스트스크립트 포함을 해제해야 정상적인 RGB모드로 저장된다.

![캡처2](https://iamtaehoon.files.wordpress.com/2015/02/ecbaa1ecb29821.png)
