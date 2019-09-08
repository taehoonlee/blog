---
title: "Easy installation for mysql on Ubuntu"
categories: [tech, unix]
tags: [mysql-installation]
---

### Installing

```
sudo apt-get install libapache2-mod-auth-mysql \
mysql-server mysql-client
```

### Running

```
sudo /etc/init.d/mysql restart
```

### Connecting

```
mysql -u root -p
```

### Settings in Korean

```
sudo vi /etc/mysql/my.cnf
```

add the following lines!

```
[mysqld]
character-set-client-handshake=FALSE
init_connect="SET collation_connection = utf8_general_ci"
init_connect="SET NAMES utf8"
default-character-set = utf8 # 이 줄은 안되면 제거
character-set-server = utf8
collation-server = utf8_general_ci
```
