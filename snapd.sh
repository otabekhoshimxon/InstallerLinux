sudo apt install -y snapd
sudo systemctl enable --now snapd apparmor
sudo snap install snap-store

echo 'Snap and Store installed'