@echo off
echo ======================================================
echo     ROS 2 Workshop Environment Setup for Windows
echo ======================================================
echo.

:: Step 1: Install WSL (Ubuntu 24.04)
echo [1/4] Installing WSL with Ubuntu 24.04 ...
wsl --install -d Ubuntu-24.04
if %errorlevel% neq 0 (
    echo WSL installation may already exist or failed.
    echo Please verify manually if needed.
)
echo.

:: Step 2: Run Docker Desktop Installer
echo [2/4] Installing Docker Desktop ...
if exist "Docker Desktop Installer.exe" (
    start /wait "" "Docker Desktop Installer.exe"
) else (
    echo ERROR: Docker Desktop Installer.exe not found in this folder.
    echo Please make sure the installer is in the same folder as this script.
    pause
    exit /b
)
echo.

:: Step 3: Launch Docker Desktop
echo [3/4] Starting Docker Desktop ...
start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"
timeout /t 15 >nul
echo.

:: Step 4: Load ROS 2 Workshop Docker Image
echo [4/4] Loading ROS 2 workshop image ...
if exist "ros2-workshop.tar" (
    docker load -i ros2-workshop.tar
) else (
    echo ERROR: ros2-workshop.tar not found in this folder.
    echo Please ensure the file is present.
    pause
    exit /b
)
echo.

echo ======================================================
echo Setup Complete!
echo You can now run run_ros2.bat or open http://localhost:6080/
echo ======================================================
pause
