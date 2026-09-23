# Mobile Habit Builder (Android Offline)

This folder contains the planning, architecture, and codebase for the **Bona Loko Mobile Habit Builder** application.

## Overview

The mobile application is an offline-first companion designed for Android that allows users to perform their initial **12 Life Areas Assessment** and determine their priority gaps.

- **Platform**: Android
- **Mode**: 100% Offline (Local SQLite database managed by Drift, zero internet permissions)
- **Domain Foundation**:
  - [specs/domain/12-life-areas.spec.md](../../specs/domain/12-life-areas.spec.md)
  - [specs/domain/priority-model.spec.md](../../specs/domain/priority-model.spec.md)

## Documentation & Roadmap

- **[STRATEGY.md](./STRATEGY.md)**: Comprehensive implementation strategy, architectural layers, SQLite schema, and phased task breakdown.

## Local commands:

- **Start Emulator (Cross-Platform Clean Cold Boot & Auto-Detected)**:
  - **Python (Universal: Windows, Linux, macOS)**:
    ```bash
    python ./scripts/run_emulator.py
    ```
  - **Linux / macOS**:
    ```bash
    ./scripts/run_emulator.sh
    ```
  - **Windows PowerShell**:
    ```powershell
    .\scripts\run_emulator.ps1
    ```
  - **Windows CMD**:
    ```cmd
    .\scripts\run_emulator.bat
    ```
- **Run the app on the connected emulator**:
  ```bash
  flutter run
  ```
- **Manual Flutter Launch**: `flutter emulators --launch Medium_Phone_API_35`
