#!/bin/sh
# -*- coding: utf-8-unix -*-
# ux-do-test.sh

# 引数があると（値が何であれ）、実ディレクトリに関するテストをする。

function exec_report {
    cmd="$1"
    echo "*** Execute: $cmd"
    eval "$cmd"
    echo "===============" >> ../ux-report.txt
    echo "*** Command: $cmd" >> ../ux-report.txt
    echo "*** Current dir:" >> ../ux-report.txt
    /bin/ls -F -R .        >> ../ux-report.txt
    echo "*** Origin dir:" >> ../ux-report.txt
    /bin/ls -F -R ../dir2  >> ../ux-report.txt
}

rm -f  ./ux-report.txt
echo "*** bash ***" > ./ux-report.txt
cd dir

sh ./setup.sh $1
exec_report "/bin/rm subdir"
sh ./setup.sh  $1
exec_report "/bin/rm -r subdir"
sh ./setup.sh  $1
exec_report "/bin/rm subdir/"
sh ./setup.sh  $1
exec_report "/bin/rm -r subdir/"
sh ./setup.sh  $1
exec_report "/bin/rm subdir/*"
sh ./setup.sh  $1
exec_report "/bin/rm -r subdir/*"
sh ./setup.sh  $1
exec_report "/bin/rmdir subdir"
sh ./setup.sh  $1
exec_report "/bin/rmdir subdir/"

cd ..
