#!/bin/bash

set -e

echo ">>> Installing Redis from source..."

# 1. Install required packages
sudo apt update
sudo apt install build-essential tcl curl -y

# 2. Download and build Redis
cd /tmp
curl -O http://download.redis.io/redis-stable.tar.gz
tar xzvf redis-stable.tar.gz
cd redis-stable
make
sudo make install

# 3. Copy default configuration
sudo mkdir -p /etc/redis
sudo cp redis.conf /etc/redis/redis.conf

# 4. Update configuration
echo ">>> Configuring Redis..."
sudo sed -i 's/^supervised .*/supervised systemd/' /etc/redis/redis.conf
sudo sed -i 's/^daemonize no/daemonize yes/' /etc/redis/redis.conf
sudo sed -i 's|^dir .*|dir /var/lib/redis|' /etc/redis/redis.conf

# 5. Create Redis user and directory
echo ">>> Creating Redis user and data directory..."
sudo adduser --system --group --no-create-home redis || true
sudo mkdir -p /var/lib/redis
sudo chown redis:redis /var/lib/redis
sudo chmod 770 /var/lib/redis

# 6. Create systemd service file
echo ">>> Creating systemd service file for Redis..."
sudo bash -c 'cat <<EOF > /etc/systemd/system/redis.service
[Unit]
Description=Redis In-Memory Data Store
After=network.target

[Service]
User=redis
Group=redis
ExecStart=/usr/local/bin/redis-server /etc/redis/redis.conf
ExecStop=/usr/local/bin/redis-cli shutdown
Restart=always

[Install]
WantedBy=multi-user.target
EOF'

# 7. Reload systemd and start Redis
echo ">>> Enabling and starting Redis service..."
sudo systemctl daemon-reload
sudo systemctl enable redis
sudo systemctl start redis

# 8. Show service status
echo ">>> Redis service status:"
sudo systemctl status redis --no-pager

# 9. Test connection
echo ">>> Testing Redis connection..."
redis-cli ping
