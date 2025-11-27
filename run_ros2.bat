@echo off
setlocal enabledelayedexpansion
echo Starting Docker container...

:: Check if Docker is running
echo Checking if Docker Desktop is running...
docker info >nul 2>&1
if errorlevel 1 (
    echo Docker Desktop is not running. Starting it now...
    start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"
    
    :: Wait for Docker to start (polling with timeout)
    echo Waiting for Docker Desktop to be ready - this may take a minute...
    set /a max_attempts=40
    set /a attempt=0
    :wait_docker
    timeout /t 3 >nul
    docker info >nul 2>&1
    if errorlevel 1 (
        set /a attempt+=1
        if !attempt! geq !max_attempts! (
            echo ERROR: Docker Desktop did not start within 2 minutes.
            echo Please start Docker Desktop manually and try again.
            pause
            exit /b 1
        )
        echo Still waiting for Docker Desktop... !attempt!/!max_attempts!
        goto wait_docker
    )
    echo Docker Desktop is ready!
) else (
    echo Docker Desktop is already running.
)
echo.

:: Check for NVIDIA GPU support
echo Checking for NVIDIA GPU support...
nvidia-smi >nul 2>&1
if errorlevel 1 (
    echo NVIDIA GPU not detected. Running without GPU acceleration.
    set GPU_FLAGS=
) else (
    echo NVIDIA GPU detected. Running with GPU acceleration.
    set GPU_FLAGS=--gpus all
)
echo.

:: Check if container "master_robotics" exists
echo Checking for existing container "master_robotics"...
docker inspect master_robotics >nul 2>&1
if errorlevel 1 (
    :: Container does not exist, create and run it
    echo Container "master_robotics" does not exist. Creating new container...
    docker run -d --name master_robotics -p 6080:80 %GPU_FLAGS% --security-opt seccomp=unconfined --shm-size=512m mec_windows:jazzy
    if errorlevel 1 (
        echo ERROR: Failed to create Docker container "master_robotics".
        echo Please check Docker is running and the image "mec_windows:jazzy" exists.
        pause
        exit /b 1
    )
    echo Container "master_robotics" created and started successfully.
) else (
    :: Container exists, check if it's running
    echo Container "master_robotics" exists.
    docker ps --filter "name=master_robotics" --format "{{.Names}}" | findstr /C:"master_robotics" >nul 2>&1
    if errorlevel 1 (
        :: Container exists but is not running, start it
        echo Container is stopped. Starting container...
        docker start master_robotics
        if errorlevel 1 (
            echo ERROR: Failed to start container "master_robotics".
            echo Please check the container status manually.
            pause
            exit /b 1
        )
        echo Container "master_robotics" started successfully.
    ) else (
        :: Container exists and is running, stop and restart it
        echo Container "master_robotics" is already running. Restarting container...
        docker stop master_robotics
        if errorlevel 1 (
            echo ERROR: Failed to stop container "master_robotics".
            echo Please check the container status manually.
            pause
            exit /b 1
        )
        echo Container stopped. Starting container again...
        docker start master_robotics
        if errorlevel 1 (
            echo ERROR: Failed to restart container "master_robotics".
            echo Please check the container status manually.
            pause
            exit /b 1
        )
        echo Container "master_robotics" restarted successfully.
    )
)
echo.

:: Show container status
echo Container status:
docker ps --filter "name=master_robotics" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
echo.
echo You can access the container at http://localhost:6080/
echo.
echo Press Ctrl+C to stop the container...
echo.

:: Follow container logs (this runs in foreground)
:: When Ctrl+C is pressed, it will break out of this command
docker logs -f master_robotics

:: This code runs when docker logs exits (including when Ctrl+C is pressed)
echo.
echo.
echo Stopping container "master_robotics"...
docker stop master_robotics
if errorlevel 1 (
    echo WARNING: Failed to stop container. It may have already stopped.
) else (
    echo Container "master_robotics" stopped successfully.
)
echo.
pause