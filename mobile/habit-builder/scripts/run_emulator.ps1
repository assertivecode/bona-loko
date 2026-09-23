<#
.SYNOPSIS
    PowerShell wrapper for run_emulator.py.
    Launches the Android emulator with a clean cold boot and waits until the OS is fully booted.

.PARAMETER AvdName
    Name of the AVD to launch (default: Medium_Phone_API_35).
#>

param (
    [string]$AvdName = "Medium_Phone_API_35"
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$pythonScript = Join-Path $scriptDir "run_emulator.py"

if (Get-Command python -ErrorAction SilentlyContinue) {
    & python $pythonScript --avd $AvdName
} elseif (Get-Command python3 -ErrorAction SilentlyContinue) {
    & python3 $pythonScript --avd $AvdName
} else {
    Write-Warning "Python not found on PATH. Please install Python or ensure it is on your PATH."
}
