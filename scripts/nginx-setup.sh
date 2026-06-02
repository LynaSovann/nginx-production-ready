#!/usr/bin/env bash

set -e

echo "=== Installing NGINX 1.30.2 ==="

# Install dependencies
dnf groupinstall "Development Tools" -y

dnf install -y \
    gcc \
    pcre \
    pcre-devel \
    zlib \
    zlib-devel \
    openssl \
    openssl-devel \
    gd \
    gd-devel

# Create nginx user if it does not exist
id nginx >/dev/null 2>&1 || useradd -r -s /sbin/nologin nginx

# Extract source
cd archive

tar -xzf nginx-1.30.2.tar.gz

cd nginx-1.30.2

# Configure
./configure \
    --sbin-path=/usr/sbin/nginx \
    --conf-path=/etc/nginx/nginx.conf \
    --error-log-path=/var/log/nginx/error.log \
    --http-log-path=/var/log/nginx/access.log \
    --user=nginx \
    --group=nginx \
    --pid-path=/var/run/nginx.pid \
    --with-http_ssl_module

# Build and install
make -j"$(nproc)"
make install

# Create required directories
mkdir -p /var/log/nginx
mkdir -p /etc/nginx

# Create systemd service
cat > /usr/lib/systemd/system/nginx.service <<'EOF'
[Unit]
Description=nginx - high performance web server
Documentation=https://nginx.org/en/docs/
After=network-online.target remote-fs.target nss-lookup.target
Wants=network-online.target

[Service]
Type=forking
PIDFile=/var/run/nginx.pid
Environment="CONFFILE=/etc/nginx/nginx.conf"
ExecStart=/usr/sbin/nginx -c ${CONFFILE}
ExecReload=/bin/sh -c "/bin/kill -s HUP $(/bin/cat /run/nginx.pid)"
ExecStop=/bin/sh -c "/bin/kill -s TERM $(/bin/cat /run/nginx.pid)"

[Install]
WantedBy=multi-user.target
EOF

# Validate configuration
/usr/sbin/nginx -t

# Reload systemd
systemctl daemon-reload

# Enable and start nginx
systemctl enable nginx
systemctl start nginx

echo
echo "========================================="
echo "OK! NGINX installation completed."
echo
systemctl status nginx --no-pager
echo "========================================="

