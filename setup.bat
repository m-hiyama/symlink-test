@echo off
rem setup.bat

rem 次のディレクトリ構造を作る。
rem 既存ファイル／ディレクトリのクリアは行わない。
rem 
rem +---dir/
rem |   |
rem |   +---subdir@ --> ../dir2
rem |
rem +---dir2/
rem     |   a.txt
rem     |
rem     +---subdir2/
rem             b.txt
rem 
rem 引数があると（引数の値に関わらず）次のディレクトリ構造を作る。
rem この場合、dir2/ はコピー元なだけで操作とは無関係になる。
rem 
rem 
rem +---dir
rem |   |   setup.bat
rem |   |
rem |   +---subdir
rem |       |   a.txt
rem |       |
rem |       +---subdir2
rem |               b.txt
rem |
rem +---dir2
rem     |   a.txt
rem     |
rem     +---subdir2
rem             b.txt

if not exist dir  mkdir dir
if not exist dir2 mkdir dir2
if not exist dir2\subdir2 mkdir dir2\subdir2
echo a > dir2\a.txt
echo b > dir2\subdir2\b.txt

cd dir
if "%1" == "" goto symlink
goto xcopy

:symlink
echo symlink
if not exist subdir mklink /D subdir ..\dir2
goto endlink

:xcopy
echo xcopy
if not exist subdir xcopy /S ..\dir2 subdir\
goto endlink

:endlink
cd ..

echo @echo off            > dir\setup.bat
echo cd ..               >> dir\setup.bat
echo call .\setup.bat %1 >> dir\setup.bat
echo cd dir              >> dir\setup.bat
