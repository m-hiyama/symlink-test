# -*- coding: sjis -*-
# ps-do-test.ps1

# real引数があると（値が何であれ）、実ディレクトリに関するテストをする。
# noForce引数があると（値が何であれ）、-Forceオプションを付けない。

param(
    [string]
    $real = "",
    [string]
    $noForce = ""
)

echo "real=$real"
echo "noForce=$noForce"

if ($noForce -eq "") {
    $opt = "-fo"
} else {
    $opt = ""
}

function exec_report ($cmd) {
    echo "*** Execute: $cmd"
    invoke-expression "$cmd"
    echo "===============" >> ../ps-report.txt
    echo "*** Command: $cmd" >> ../ps-report.txt
    echo "*** Current dir:"  >> ../ps-report.txt
    ls -r . | select name      >> ../ps-report.txt
    echo "*** Origin dir:"   >> ../ps-report.txt
    ls -r ../dir2  | select name >> ../ps-report.txt
#    ls -r ../  | select name >> ../ps-report.txt
}

rm ./ps-report.txt
echo "*** PowerShell ***" > ./ps-report.txt
cd dir

& ./setup.bat $real
exec_report "rm $opt subdir"
& ./setup.bat $real
exec_report "rm $opt -r subdir"
& ./setup.bat $real
exec_report "rm $opt subdir\"
& ./setup.bat $real
exec_report "rm $opt -r subdir\"
& ./setup.bat $real
exec_report "rm $opt subdir\*"
& ./setup.bat $real
exec_report "rm $opt -r subdir\*"
& ./setup.bat $real
exec_report "rmdir $opt subdir"
& ./setup.bat $real
exec_report "rmdir $opt subdir\"
& ./setup.bat $real
exec_report "rmdir $opt -r subdir"
& ./setup.bat $real
exec_report "rmdir $opt -r subdir\"

cd ..
