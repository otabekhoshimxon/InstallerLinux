#!/bin/bash

set -e

echo ">>> Redis o'rnatilmoqda..."

# 1. Zarur paketlarni o'rnatish
sudo apt update
sudo apt install build-essential tcl curl -y

# 2. Redis manba kodini yuklab olish
cd /tmp
curl -O http://download.redis.io/redis-stable.tar.gz
tar xzvf redis-stable.tar.gz
cd redis-stable
make
sudo make install

# 3. Konfiguratsiya faylini ko'chirish
sudo mkdir -p /etc/redis
sudo cp redis.conf /etc/redis/redis.conf

# 4. redis.conf faylini sozlash
sudo sed -i 's/^supervised .*/supervised systemd/' /etc/redis/redis.conf
sudo sed -i 's/^daemonize no/daemonize yes/' /etc/redis/redis.conf
sudo sed -i 's|^dir .*|dir /var/lib/redis|' /etc/redis/redis.conf

# 5. Redis uchun user va kataloglar
sudo adduser --system --group --no-create-home redis || true
sudo mkdir -p /var/lib/redis
sudo chown redis:redis /var/lib/redis
sudo chmod 770 /var/lib/redis

# 6. systemd service faylini yaratish
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

# 7. Xizmatni yoqish va ishga tushirish
sudo systemctl daemon-reload
sudo systemctl enable redis
sudo systemctl start redis

# 8. Holatini ko'rsatish
echo ">>> Redis holati:"
sudo systemctl status redis --no-pager

# 9. Test
echo ">>> Redis test: "
redis-cli ping
