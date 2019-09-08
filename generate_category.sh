#!/bin/sh

mkdir category
mkdir category/tech
mkdir category/misc

MAIN="tech misc"
SUB1="bioinformatics machine-learning matlab medical-imaging misc probability unix writing"
SUB2="reading thoughts"

for main in $MAIN
do
  echo "---\nlayout: category\ntitle: ${main}\n---" > "category/"$main".md"
done

for sub1 in $SUB1
do
  echo "---\nlayout: category\ntitle: tech/${sub1}\n---" > "category/tech/"$sub1".md"
done

for sub2 in $SUB2
do
  echo "---\nlayout: category\ntitle: misc/${sub2}\n---" > "category/misc/"$sub2".md"
done
