---
title: "My favorite unix commands"
categories: [tech, unix]
tags: [awk, scp, Unix-Command]
---

1. View file information
  - List all the files: `ls -a`
  - Count the number of files: `ls -l | grep ^- | wc -l`
  - Count the number of lines in a file: `wc -l file.txt`

2. View disk information
  - Check the amount of disk space: `df -h`
  - Display disk usage of a directory: `du -sh ./`

3. Transfer files
  - Download serverfolder from a server
```
scp -r username@servername:/serverpath/serverfolder/ ./
```
(/serverpath/serverfolder/* -> ./serverfolder/*)
  - Upload localfolder to a server
```
scp -r ./localfolder/ username@servername:/serverpath/
```
(./localfolder/* -> /serverpath/localfolder/*)

4. Extract the third field in a file
```
awk '{ print $3 }' file.txt
cat file.txt | awk '{ print $3 }'
```

5. Display the first three lines in a file
```
head -n 3 file.txt
```

6. Set permissions
  - Change group owner and file owner to ‘username’
```
chown username:username file.txt
```
  - Assign the permission to write to (user/group/others/all)
```
chmod u+w file.txt
chmod g+w file.txt
chmod o+w file.txt
chmod a+w file.txt
```

7. Compress files
  - .tar.gz: `tar cvzf file.tar.gz foldername`
  - .bz2: `bzip2 -k foldername`

8. Decompress files
  - .tar.gz: `tar xvzf file.tar.gz` or `gunzip file.tar.gz`
  - .bz2: `bzip2 -kd file.txt.bz2`
  - .tar.bz2: `tar -xvjpf file.tar.bz2`
  - .tar: `tar xvf file.tar`
  - .gz: `gzip -d file.gz`
