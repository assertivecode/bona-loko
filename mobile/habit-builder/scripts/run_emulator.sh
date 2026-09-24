#!/usr/bin/env bash
# POSIX shell script wrapper for run_emulator.py
# Works on Linux and macOS

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if command -v python3 &>/dev/null; then
    exec python3 "${SCRIPT_DIR}/run_emulator.py" "$@"
elif command -v python &>/dev/null; then
    exec python "${SCRIPT_DIR}/run_emulator.py" "$@"
else
    echo "Error: Python 3 is required to run this script. Please install python3." >&2
    exit 1
fi
