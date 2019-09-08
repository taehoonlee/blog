---
title: "Easy installation for ruby and jekyll"
categories: [tech, unix]
tags: [jekyll-installation, ruby-installation]
---

Github 개인 페이지 관리를 위해 `jekyll`을 설치하고 싶었는데 `ruby`가 먼저 설치되어 있어야 했다. 이 예제에서는 mysite라는 이름으로 페이지를 생성했는데, [github free hosting](https://pages.github.com/)을 사용하기 위해서는 github repository 이름을 `username.github.io`으로 하여 생성한 뒤, local에서 clone하고 `jekyll new username.github.io`만 하면 클리어! 너무 쉽다ㅠㅠ

## Ruby on Ubuntu 14.04

[여기](https://gorails.com/setup/ubuntu/14.04)를 참조하여 설치 완료.

```
cd
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

git clone https://github.com/rbenv/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

rbenv install 2.3.1
rbenv global 2.3.1
ruby -v
```

## Ruby on OS X El Capitan

OS X 에서는 `ruby`가 기본적으로 깔려 있으나, [여기](https://gorails.com/setup/osx/10.11-el-capitan)를 참조하여 최신 버전으로 업데이트 완료.

```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install rbenv ruby-build

echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
source ~/.bash_profile

rbenv install 2.3.1
rbenv global 2.3.1
ruby -v
```

## Jekyll

`ruby`가 설치 되었다면 아래와 같이 쉽게 설치할 수 있다. [공식 홈페이지](https://jekyllrb.com/) 참조.

```
gem install jekyll # if OS X, you might use sudo
jekyll new mysite
cd mysite
jekyll serve
```
