@echo off
for /f "tokens=2 delims==" %%a in ('wmic os get Version /value') do set SystemCompilation=%%a
for /f "tokens=2 delims==" %%a in ('wmic os get BuildNumber /value') do set BuildNumber=%%a
echo          DISCLAIMER
echo I am not responsible for 
echo any damage done on your 
echo system. This was made for 
echo educational purposes.
echo Press any key to continue...
pause > nul
goto cmd

:cmd
cls
echo Windows TrustedInstaller
echo Build Number: %BuildNumber%
echo System Compilation: %SystemCompilation%
set /p cmd="Enter Command here: "

if "%cmd%"=="" goto cmd
goto execute

:execute
echo Executing...
sc config TrustedInstaller binPath= "cmd.exe /c %cmd% > C:\Windows\Temp\output.txt" > nul
echo Starting TrustedInstaller...
sc start TrustedInstaller > nul
timeout /t 2 > nul
msg * TrustedInstaller Successfully Started
echo Output from the command:
type C:\Windows\Temp\output.txt
echo Stopping TrustedInstaller...
sc stop TrustedInstaller > nul
echo Reverting TrustedInstaller binPath...
sc config TrustedInstaller binPath= "C:\Windows\servicing\TrustedInstaller.exe" > nul
echo Press any key to go back...
pause > nul
goto cmd
