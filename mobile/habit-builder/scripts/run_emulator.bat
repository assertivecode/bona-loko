@echo off
REM Batch wrapper for run_emulator.py on Windows Command Prompt
python "%~dp0run_emulator.py" %*
if %ERRORLEVEL% NEQ 0 (
    powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0run_emulator.ps1" %*
)
