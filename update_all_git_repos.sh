#!/bin/sh

root=`pwd`
for file in `ls -d */.git`;
do
  folder=`echo $file | sed 's/\.git//'`
  echo $folder
  cd $folder
  git pull
  echo ""
  cd $root
done
