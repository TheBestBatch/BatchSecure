@echo off
color 84
title Batch Secure
If exist "%cd%\AES.exe" goto :fi
echo You don't have AES.exe please download it
pause
exit
:fi
set Fa=0
If exist "%cd%\Password.txt.key" goto :a
echo. >>Password.txt
goto :lock
:a
title Batch Secure - Unlock procedure
set /p "MDP=Master Key >"
AES -d -p %MDP% Password.txt.key
If exist "%cd%\Password.txt" goto :b
set /a Fa=%Fa%+1
cls
echo Wrong Master key (%Fa% attempts made)
timeout /t 2 /nobreak >nul
goto :a
:b
title Batch Secure
cls
del Password.txt.key
cls
more Password.txt
echo.
echo If you want to edit write edit
set /p "Cho=>"
If "%cho%"=="edit" goto :edit
:lock
cls
title Batch Secure - Lock procedure
set /p "MDP=MasterKey >"
AES -e -p %MDP% Password.txt
ren Password.txt.aes Password.txt.key
del Password.txt
cls
echo Password crypted
echo MasterKey : %MDP%
pause
exit
:edit
start notepad.exe "%cd%\Password.txt"
pause
goto :lock
