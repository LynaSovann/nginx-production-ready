# nginx-production-ready

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configure Nginx as Web Server](#configure-nginx-as-web-server)
- [Configure Nginx as Reverse Proxy](#configure-nginx-as-reverse-proxy)
- [Configure Nginx as Load Balancer](#configure-nginx-as-load-balancer)

## Prerequisites

- AlmaLinux or RHEL 9.x
- Outbound internet access on TCP port 443

## Installation

1. SSH to the target machine.

2. Switch to the root user.

3. Update system packages.

```bash
dnf update -y
```

4. Install Git.

```bash
dnf install git -y
```

5. Navigate to `/tmp`.

```bash
cd /tmp
```

6. Clone the repository.

```bash
git clone -b main https://github.com/LynaSovann/nginx-production-ready.git
```

7. Navigate to the project directory.

```bash
cd nginx-production-ready
```

8. Run the installation script.

```bash
chmod +x scripts/nginx-setup.sh
./scripts/nginx-setup.sh
```

## Configure Nginx as Web Server

## Configure Nginx as Reverse Proxy

## Configure Nginx as Load Balancer
