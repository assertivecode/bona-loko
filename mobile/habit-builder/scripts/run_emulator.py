#!/usr/bin/env python3
"""
Cross-Platform Android Emulator Launcher for Bona Loko Habit Builder.
Works on Windows, Linux, and macOS.

Features:
- Auto-discovers Android SDK on Windows, Linux, and macOS.
- Terminates lingering/stuck emulator and QEMU processes.
- Restarts ADB server to clear stale socket states.
- Cold-boots the emulator (-no-snapshot-load) in a detached process.
- Polls ADB until 'sys.boot_completed=1'.
- Verifies detection with 'flutter devices'.
"""

import argparse
import os
import platform
import subprocess
import sys
import time
from pathlib import Path


def find_android_sdk() -> Path:
    """Finds the Android SDK directory based on environment variables and standard OS locations."""
    # Check environment variables first
    env_vars = ["ANDROID_HOME", "ANDROID_SDK_ROOT"]
    for var in env_vars:
        val = os.environ.get(var)
        if val and Path(val).is_dir():
            return Path(val)

    system = platform.system()
    home = Path.home()

    candidates = []
    if system == "Windows":
        local_app_data = os.environ.get("LOCALAPPDATA")
        if local_app_data:
            candidates.append(Path(local_app_data) / "Android" / "Sdk")
        candidates.append(Path("C:/Program Files/Android/Android Studio/sdk"))
    elif system == "Darwin":  # macOS
        candidates.append(home / "Library" / "Android" / "sdk")
    elif system == "Linux":
        candidates.append(home / "Android" / "Sdk")
        candidates.append(Path("/opt/android-sdk"))
        candidates.append(home / ".android" / "sdk")

    for candidate in candidates:
        if candidate.is_dir():
            return candidate

    print("Error: Could not locate Android SDK.")
    print("Please set the ANDROID_HOME or ANDROID_SDK_ROOT environment variable.")
    sys.exit(1)


def get_binary_path(sdk_dir: Path, subfolder: str, binary_name: str) -> Path:
    """Returns the full path to a binary inside the SDK, taking OS extensions into account."""
    ext = ".exe" if platform.system() == "Windows" else ""
    target = sdk_dir / subfolder / f"{binary_name}{ext}"
    if not target.is_file():
        # Fallback to PATH lookup
        from shutil import which
        which_result = which(f"{binary_name}{ext}")
        if which_result:
            return Path(which_result)
        print(f"Error: Could not locate {binary_name} at {target} or on PATH.")
        sys.exit(1)
    return target


def terminate_existing_emulators():
    """Kills any stuck or existing emulator and QEMU instances across platforms."""
    system = platform.system()
    print("[1/5] Checking for existing emulator processes...")
    try:
        if system == "Windows":
            # Silently kill emulator.exe and qemu-system-x86_64.exe
            subprocess.run(
                ["taskkill", "/F", "/IM", "emulator.exe"],
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
            )
            subprocess.run(
                ["taskkill", "/F", "/IM", "qemu-system-x86_64.exe"],
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
            )
        else:
            # Linux and macOS
            subprocess.run(
                ["pkill", "-9", "-f", "emulator|qemu-system"],
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
            )
        time.sleep(1)
    except Exception:
        pass


def restart_adb(adb_path: Path):
    """Restarts the ADB daemon to clear stale socket states."""
    print("[2/5] Restarting ADB server...")
    try:
        subprocess.run([str(adb_path), "kill-server"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        time.sleep(1)
        subprocess.run([str(adb_path), "start-server"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        time.sleep(1)
    except Exception as e:
        print(f"Warning: ADB restart issue: {e}")


def launch_emulator(emulator_path: Path, avd_name: str, cold_boot: bool = False):
    """Launches the emulator in a detached, independent process with host GPU acceleration."""
    mode = "Cold-booting (-no-snapshot-load)" if cold_boot else "Fast-booting with snapshot support"
    print(f"[3/5] {mode} AVD '{avd_name}' in background...")
    args = [str(emulator_path), "-avd", avd_name]
    if cold_boot:
        args.append("-no-snapshot-load")

    kwargs = {
        "stdout": subprocess.DEVNULL,
        "stderr": subprocess.DEVNULL,
    }

    if platform.system() == "Windows":
        DETACHED_PROCESS = 0x00000008
        CREATE_NEW_PROCESS_GROUP = 0x00000200
        kwargs["creationflags"] = DETACHED_PROCESS | CREATE_NEW_PROCESS_GROUP
    else:
        kwargs["start_new_session"] = True

    subprocess.Popen(args, **kwargs)


def wait_for_boot(adb_path: Path, max_wait_seconds: int = 120) -> bool:
    """Waits for ADB detection and polls 'sys.boot_completed=1'."""
    print("[4/5] Waiting for Android OS to boot and initialize...")
    print("      Waiting for ADB handshake...", end="", flush=True)

    # Initial wait-for-device
    try:
        subprocess.run([str(adb_path), "wait-for-device"], timeout=30, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    except subprocess.TimeoutExpired:
        pass

    print(" Connected!")
    print("      Waiting for boot completion", end="", flush=True)

    start_time = time.time()
    while time.time() - start_time < max_wait_seconds:
        try:
            res = subprocess.run(
                [str(adb_path), "shell", "getprop", "sys.boot_completed"],
                capture_output=True,
                text=True,
                timeout=5,
            )
            if res.stdout.strip() == "1":
                print(" Done!")
                return True
        except Exception:
            pass

        print(".", end="", flush=True)
        time.sleep(2)

    print("\nWarning: Timed out waiting for boot completion.")
    return False


def verify_flutter():
    """Runs 'flutter devices' to verify the device is ready."""
    print("[5/5] Checking connected Flutter devices...")
    from shutil import which
    flutter_bin = which("flutter")
    if flutter_bin:
        subprocess.run([flutter_bin, "devices"])
    else:
        print("Note: 'flutter' command not found in PATH. Ensure Flutter SDK is installed.")


def main():
    parser = argparse.ArgumentParser(description="Cross-platform Android Emulator Launcher for Bona Loko.")
    parser.add_argument(
        "--avd",
        default="Pixel_7_API_35",
        help="Name of the Android Virtual Device to launch (default: Pixel_7_API_35)",
    )
    parser.add_argument(
        "--cold-boot",
        action="store_true",
        help="Force cold-boot without loading snapshot (-no-snapshot-load)",
    )
    args = parser.parse_args()

    print("====================================================")
    print(f" Bona Loko Emulator Launcher ({platform.system()})")
    print("====================================================")

    sdk = find_android_sdk()
    print(f"-> Android SDK: {sdk}")

    emulator_bin = get_binary_path(sdk, "emulator", "emulator")
    adb_bin = get_binary_path(sdk, "platform-tools", "adb")

    terminate_existing_emulators()
    restart_adb(adb_bin)
    launch_emulator(emulator_bin, args.avd, cold_boot=args.cold_boot)
    
    is_ready = wait_for_boot(adb_bin)
    print()

    if is_ready:
        print("====================================================")
        print(f" Emulator '{args.avd}' is ONLINE and READY! ")
        print("====================================================")
        verify_flutter()
        print("\nYou can now run your app with:")
        print("    flutter run\n")
    else:
        print(f"Check the emulator window. Once booted, run 'flutter devices' and 'flutter run'.")


if __name__ == "__main__":
    main()
