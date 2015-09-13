@echo off

rme 引数があると（値が何であれ）、実ディレクトリに関するテストをする。

del  .\cmd-report.txt
echo *** cmd.exe *** > .\cmd-report.txt

cd dir

call .\setup.bat %1
call :exec_report del subdir
call .\setup.bat %1
call :exec_report del /s subdir
call .\setup.bat %1
call :exec_report del subdir\
call .\setup.bat %1
call :exec_report del /s subdir\
call .\setup.bat %1
call :exec_report del subdir\*
call .\setup.bat %1
call :exec_report del /s subdir\*
call .\setup.bat %1
call :exec_report rmdir subdir
call .\setup.bat %1
call :exec_report rmdir subdir\
call .\setup.bat %1
call :exec_report rmdir /s subdir
call .\setup.bat %1
call :exec_report rmdir /s subdir\

cd ..

goto end

:exec_report
echo *** Execute: %1 %2 %3 %4
%1 %2 %3 %4
echo =============== >> ..\cmd-report.txt
echo *** Command: %1 %2 %3 %4 >> ..\cmd-report.txt
echo *** Current dir:         >> ..\cmd-report.txt
dir /b /s .                   >> ..\cmd-report.txt
echo *** Origin dir:          >> ..\cmd-report.txt
dir /b /s ..\dir2             >> ..\cmd-report.txt
exit /b 0

:end
