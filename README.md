# **Building Intelligent Robots with ROS 2 & AI Agents**

## **Workshop Environment Setup Guide**

This workshop uses a **pre-configured Docker container** to ensure every participant has a consistent ROS 2 Jazzy + AI environment across **Ubuntu 24.04**, **Windows 11**, and **macOS**.

Once the container is launched, you will get an **Ubuntu desktop inside your web browser** at:

👉 **[http://127.0.0.1:6080/](http://127.0.0.1:6080/)**

---

# **📑 Table of Contents**

1. [Overview](#overview)
2. [System Requirements](#system-requirements)
3. [Docker Installation](#docker-installation)
   - [Ubuntu 24.04 LTS](#ubuntu-2404-lts)
   - [Windows 11 (WSL + Docker Desktop)](#windows-11-wsl--docker-desktop)
   - [macOS](#macos)
4. [Run the Workshop Docker Container](#run-the-workshop-docker-container)
5. [Access the Web-based Ubuntu Desktop](#access-the-web-based-ubuntu-desktop)
6. [Stopping the Container](#stopping-the-container)
7. [Repository Structure](#repository-structure)

---

# **1. Overview**

This repository contains everything needed to run the **Building Intelligent Robots with ROS 2 & AI Agents** workshop in a Docker-based sandbox.

You only need:

* Docker installed
* One simple docker run command

---

# **2. System Requirements**

* **Ubuntu 24.04**, **Windows 11**, or **macOS**
* 8 GB RAM (minimum)
* 15 GB free disk space
* Modern browser (Chrome recommended)
* (Optional) NVIDIA GPU for accelerated workloads

---

# **3. Docker Installation**

Below are OS-specific instructions.

---

# **A. Ubuntu 24.04 LTS**

A script is provided to install:

* Docker Engine
* NVIDIA Container Toolkit
* Required dependencies

### **Run the setup script**

```bash
cd docker_setup_scripts
chmod +x setup_docker_ubuntu.sh
sudo ./setup_docker_ubuntu.sh
```

Manual installation of Docker on Ubuntu 24.04

<p align="center">
  <a href="https://youtu.be/FWWq83IGUgw" target="_blank" rel="noopener noreferrer">
    <img src="https://img.youtube.com/vi/FWWq83IGUgw/hqdefault.jpg" alt="Additional workshop video" width="560" height="315"/>
  </a>
</p>

Manual Installation of Docker on Ubuntu 22.04


<p align="center">
  <a href="https://youtu.be/EuSVD7kVCUY" target="_blank" rel="noopener noreferrer">
    <img src="https://img.youtube.com/vi/EuSVD7kVCUY/hqdefault.jpg" alt="Workshop video" width="560" height="315"/>
  </a>
</p>






### **Verify**

```bash
docker --version
```

---

# **B. Windows 11 (WSL + Docker Desktop)**

On Windows, we use:

1. **WSL (Ubuntu 24.04)**
2. **Docker Desktop** (which uses WSL backend)

No Docker installation is needed **inside WSL** — Docker Desktop handles everything.

<p align="center">
  <a href="https://youtu.be/fsR8fj7iCNY" target="_blank" rel="noopener noreferrer">
    <img src="https://img.youtube.com/vi/fsR8fj7iCNY/hqdefault.jpg" alt="Workshop intro video" width="640" height="480"/>
  </a>
</p>


---

## **Step 1 — Install WSL (Ubuntu 24.04)**

Open **PowerShell as Administrator**:

```powershell
wsl --install -d Ubuntu-24.04
```

If Ubuntu 24.04 isn’t listed:

```powershell
wsl --list --online
```

After installation:

* Reboot if prompted
* Launch **Ubuntu 24.04** from Start Menu
* Create your Linux username/password

---

## **Step 2 — Install Docker Desktop**

1. Download:
   [https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/)
2. Install normally
3. Ensure **"Use the WSL 2 based engine"** is enabled
4. Start Docker Desktop

---

## **Step 3 — Enable Docker Integration with WSL**

Open **Docker Desktop → Settings → Resources → WSL Integration**.

Enable:

```
Ubuntu-24.04 → [✔] Enable integration
```

---

## **Step 4 — Verify Installation**

Run in PowerShell or WSL:

```bash
docker --version
```

---

# **C. macOS**

Docker Desktop is the recommended installation method.

Works on:

* Intel Macs
* Apple Silicon (M1/M2/M3) Macs


<p align="center">
  <a href="https://youtu.be/-EXlfSsP49A" target="_blank" rel="noopener noreferrer">
    <img src="https://img.youtube.com/vi/-EXlfSsP49A/hqdefault.jpg" alt="Workshop video" width="560" height="315"/>
  </a>
</p>


### **Steps**

1. Download Docker Desktop:
   [https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/)
2. Install and launch
3. Verify:

   ```bash
   docker --version
   ```

---

# **4. Run the Workshop Docker Container**

Once Docker is installed on any OS, run:

```bash
docker run -p 6080:80 --security-opt seccomp=unconfined --shm-size=512m ros2_llm_workshop:jazzy
```

This starts:

* A full Ubuntu desktop inside the container
* A web server for noVNC remote desktop

---

# **5. Access the Web-based Ubuntu Desktop**

Open your browser:

👉 **[http://127.0.0.1:6080/](http://127.0.0.1:6080/)**

You will see a complete workspace with:

* ROS 2 Jazzy
* AI Agent tools
* Editors and dev tools
* Workshop files

All exercises will be performed inside this desktop.

---

# **6. Stopping the Container**

Press **Ctrl + C** in the terminal that started the container,
or stop manually:

```bash
docker ps
docker stop <container_id>
```

---

# **7. Repository Structure**

```
docker_setup_scripts/
    └── setup_docker_ubuntu.sh   # Auto-installer for Ubuntu 24.04
README.md
...
```

---

