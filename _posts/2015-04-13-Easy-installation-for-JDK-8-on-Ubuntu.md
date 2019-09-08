---
title: "Easy installation for JDK 8 on Ubuntu"
categories: [tech, unix]
tags: [JDK-Installation]
---

1. Downloading
  - Go [http://www.oracle.com/technetwork/java/javase/downloads/](http://www.oracle.com/technetwork/java/javase/downloads/)
  - Click the JDK download button<br />![w660p](https://iamtaehoon.files.wordpress.com/2015/04/ecbaa1ecb298.png)
  - Accept the license agreement and click the linux-x64.tar.gz<br />![w660p](https://iamtaehoon.files.wordpress.com/2015/04/ecbaa1ecb2982.png)

2. Installing
  - Move to the desired java home (I recommended “/usr/local/”) and decompress the file
```
cd /usr/local/
sudo mv ~/Downloads/jdk-8u40-linux-x64.tar.gz ./
sudo tar xvzf jdk-8u40-linux-x64.tar.gz
```

3. Setting (recommended)
  - Open /etc/profile
```
vi /etc/profile
```
  - Add the following two lines
```
export JAVA_HOME="/usr/local/jdk1.8.0_40"
PATH="$JAVA_HOME/bin:$PATH"
```
