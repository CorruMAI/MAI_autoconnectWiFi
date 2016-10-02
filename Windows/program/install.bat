mkdir "%PROGRAMFILES%\CorruptedProject\MAIautoconnect"
copy "%~dp0MAIautoconnect_WIN.exe" "%PROGRAMFILES%\CorruptedProject\MAIautoconnect"
copy "%~dp0uninstall.bat" "%PROGRAMFILES%\CorruptedProject\MAIautoconnect"
copy "%~dp0SimpleWifi.dll" "%PROGRAMFILES%\CorruptedProject\MAIautoconnect"
sc create MAIautoconnectServive binpath= "%PROGRAMFILES%\CorruptedProject\MAIautoconnect\MAIautoconnect_WIN.exe"
sc config MAIautoconnectServive start= auto
sc start MAIautoconnectServive
echo "Saved. Path: %PROGRAMFILES%\CorruptedProject\"
pause