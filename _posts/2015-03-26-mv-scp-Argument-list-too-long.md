---
title: "mv, scp: Argument list too long"
categories: [tech, unix]
tags: [Argument-list-too-long, mv, scp]
---

mv 혹은 scp를 이용해서 파일 전체를 이동하려고 할 때, Argument list too long이라는 문구가 등장하는 경우가 있다. 예를 들어, folder1에 있는 모든 파일을 folder2로 옮긴다고 하자.

```
$ mv folder1/* folder2/
bash: /bin/mv: Argument list too long
```

folder1에 있는 파일 목록이 mv에 인자로 들어가는데, 그 개수가 일정 수준을 넘어가면 한번에 처리할 수 없다는 이야기이다. 여러 가지 해결책이 있지만, 나는 아래와 같이 시원하게 폴더째로 옮기는 것을 추천한다.

```
$ mv folder1/ folder2/
```

사실 위의 커맨드는 folder1를 folder2로 이름만 변경한다. 그래서 folder2가 없으면 의도대로 folder1/* 이 folder2/* 로 이동되지만, folder2가 존재한다면 folder2의 하위 폴더로 folder1이 생성된다. 이럴 때에는 아래와 같이 shell에서 for문을 사용할 수 있다.

```
$ for f in folder1/*; do mv "$f" folder2/; done
```

find를 사용하는 방법도 있는데, 자칫 위험할 수 있다고 한다. ([http://stackoverflow.com/questions/11289551/argument-list-too-long-error-for-rm-cp-mv-commands](http://stackoverflow.com/questions/11289551/argument-list-too-long-error-for-rm-cp-mv-commands))

마찬가지로, scp도 파일이 너무 많으면 아래와 같은 명령어에 대해 에러가 발생한다.
```
$ scp username@servername:/serverpath/serverfolder/* ./
bash: /usr/bin/scp: Argument list too long
```

역시 나는 아래처럼 디렉토리째로 복사하는 것을 추천한다.
```
$ scp -r username@servername:/serverpath/serverfolder/ ./
```
