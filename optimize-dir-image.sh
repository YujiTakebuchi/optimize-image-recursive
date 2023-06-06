#!/bin/bash
[ "x$1" = "x" ] && exit 1
#引数にファイルパスを代入
SRC=$1

cd $SRC

for dir in `find . -type d -depth 1 -maxdepth 1`; do
    dirName=`basename $dir`
    echo $dir
    echo $dirName
    DIST="opt-$dirName"
    mkdir $DIST
    echo $DIST
    for file in `find $dir -name '*.JPG'`; do
        fileName=`basename $file .JPG`
        echo $fileName
        ffmpeg -i $file -vf "scale=1280:-1" -q 2 "${DIST}/${fileName}.JPG" -loglevel error
    done
done

cd ..