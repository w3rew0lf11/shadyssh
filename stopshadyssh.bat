@echo off
:: StopShadowSSH — Fully Silent Revert Script

:: Step 1: Request Administrator Privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -WindowStyle Hidden -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: Step 2: Stop SSH Services and Disable Startup
powershell -WindowStyle Hidden -Command "if (Get-Service sshd -ErrorAction SilentlyContinue) { Stop-Service sshd; Set-Service sshd -StartupType Disabled }"
powershell -WindowStyle Hidden -Command "if (Get-Service ssh-agent -ErrorAction SilentlyContinue) { Stop-Service ssh-agent; Set-Service ssh-agent -StartupType Disabled }"

:: Step 3: Disable File Sharing Firewall Rules
powershell -WindowStyle Hidden -Command "netsh advfirewall firewall set rule name='File and Printer Sharing (SMB-In)' new enable=No"
powershell -WindowStyle Hidden -Command "netsh advfirewall firewall set rule name='File and Printer Sharing (NB-Session-In)' new enable=No"

:: Step 4: Deactivate Administrator Account
powershell -WindowStyle Hidden -Command "net user Administrator /active:no"

:: Step 5: Remove Administrator from SpecialAccounts (Hide from Login)
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" /v Administrator /f >nul 2>&1

:: Step 6: Finish Silently
exit
