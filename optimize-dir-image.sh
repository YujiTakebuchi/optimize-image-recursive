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
    for file in `find $dir -name '*.JPG' -or -name '*.jpg' -or -name '*.jpeg' -or -name '*.png'`; do
        ext=${file##*.}
        fileName=`basename $file .$ext`
        echo $fileName
        if [[ $ext = "png" ]]; then
            cp $file ${DIST}/${fileName}.${ext}
        else
            ffmpeg -i $file -vf "scale=720:-1" -q 2 "${DIST}/${fileName}.${ext}" -loglevel error
        fi
    done
done

cd ..