@echo off
rem setup.bat

rem ���̃f�B���N�g���\�������B
rem �����t�@�C���^�f�B���N�g���̃N���A�͍s��Ȃ��B
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
rem ����������Ɓi�����̒l�Ɋւ�炸�j���̃f�B���N�g���\�������B
rem ���̏ꍇ�Adir2/ �̓R�s�[���Ȃ����ő���Ƃ͖��֌W�ɂȂ�B
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
