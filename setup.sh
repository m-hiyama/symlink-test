#!/bin/sh
# -*- coding: utf-8-unix -*-
# setup.sh

# 次のディレクトリ構造を作る。
# 既存ファイル／ディレクトリのクリアは行わない。
# 
# +---dir/
# |   |
# |   +---subdir@ --> ../dir2
# |
# +---dir2/
#     |   a.txt
#     |
#     +---subdir2/
#             b.txt
# 
# 引数があると（引数の値に関わらず）次のディレクトリ構造を作る。
# この場合、dir2/ はコピー元なだけで操作とは無関係になる。
# 
# 
# +---dir
# |   |   setup.bat
# |   |
# |   +---subdir
# |       |   a.txt
# |       |
# |       +---subdir2
# |               b.txt
# |
# +---dir2
#     |   a.txt
#     |
#     +---subdir2
#             b.txt

if [ ! -d  dir ]; then
    mkdir dir
fi
if [ ! -d  dir2 ]; then
    mkdir dir2
fi
if [ ! -d dir2/subdir2 ]; then
    mkdir dir2/subdir2
fi
echo a > dir2/a.txt
echo b > dir2/subdir2/b.txt

if [ "$1" = "" ]; then
    LN="ln -s"
else
    LN="cp -r"
fi

cd dir
if [ ! -d subdir ]; then
    $LN ../dir2  subdir
fi
cd ..

echo cd ..             > dir/setup.sh
echo sh ./setup.sh $1  >> dir/setup.sh
echo cd dir            >> dir/setup.sh
