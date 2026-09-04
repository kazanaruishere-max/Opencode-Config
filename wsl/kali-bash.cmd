@echo off
REM kali-bash trampoline: PowerShell does the arg parsing (cmd.exe mangles metachars like > &&).
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0kali-bash.ps1" %*
