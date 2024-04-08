#!/bin/bash
# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Echo colored text
echo -e "${RED}Google installing${NC}"

sudo apt-get install libxss1 libappindicator1 libindicator7
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome*.deb
sudo apt-get install -f

echo -e "${GREEN}Google installed ${NC}"

echo -e "${RED}JetBrains Toolbox installing${NC}"

set -e
set -o pipefail

TMP_DIR="/tmp"
INSTALL_DIR="$HOME/.local/share/JetBrains/Toolbox/bin"
SYMLINK_DIR="$HOME/.local/bin"

echo "### INSTALL JETBRAINS TOOLBOX ###"

echo -e "\e[94mFetching the URL of the latest version...\e[39m"
ARCHIVE_URL=$(curl -s 'https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release' | grep -Po '"linux":.*?[^\\]",' | awk -F ':' '{print $3,":"$4}'| sed 's/[", ]//g')
ARCHIVE_FILENAME=$(basename "$ARCHIVE_URL")

echo -e "\e[94mDownloading $ARCHIVE_FILENAME...\e[39m"
rm "$TMP_DIR/$ARCHIVE_FILENAME" 2>/dev/null || true
wget -q --show-progress -cO "$TMP_DIR/$ARCHIVE_FILENAME" "$ARCHIVE_URL"

echo -e "\e[94mExtracting to $INSTALL_DIR...\e[39m"
mkdir -p "$INSTALL_DIR"
rm "$INSTALL_DIR/jetbrains-toolbox" 2>/dev/null || true
tar -xzf "$TMP_DIR/$ARCHIVE_FILENAME" -C "$INSTALL_DIR" --strip-components=1
rm "$TMP_DIR/$ARCHIVE_FILENAME"
chmod +x "$INSTALL_DIR/jetbrains-toolbox"

echo -e "\e[94mSymlinking to $SYMLINK_DIR/jetbrains-toolbox...\e[39m"
mkdir -p $SYMLINK_DIR
rm "$SYMLINK_DIR/jetbrains-toolbox" 2>/dev/null || true
ln -s "$INSTALL_DIR/jetbrains-toolbox" "$SYMLINK_DIR/jetbrains-toolbox"

if [ -z "$CI" ]; then
	echo -e "\e[94mRunning for the first time to set-up...\e[39m"
	( "$INSTALL_DIR/jetbrains-toolbox" & )
	echo -e "\n\e[32mDone! JetBrains Toolbox should now be running, in your application list, and you can run it in terminal as jetbrains-toolbox (ensure that $SYMLINK_DIR is on your PATH)\e[39m\n"
else
	echo -e "\n\e[32mDone! Running in a CI -- skipped launching the AppImage.\e[39m\n"
fi

echo -e "${GREEN}JetBrains Toolbox installed ${NC}"



echo -e "${RED}Postgres 15 installing${NC}"
sudo apt update
sudo apt -y upgrade
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt update
sudo apt install postgis postgresql-15-postgis-3
sudo -i -u postgres psql
echo " Enable PostGIS
       CREATE EXTENSION postgis;
       SELECT PostGIS_version();
     "
echo -e "${GREEN}Postgres 15 installed ${NC}"
echo -e "${RED}Postgres latest installing${NC}"
sudo apt update && sudo apt dist-upgrade -y
sudo apt-cache search postgresql | grep postgresql
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget -qO- https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo tee /etc/apt/trusted.gpg.d/pgdg.asc &>/dev/null
sudo apt update -y
sudo apt install postgresql postgresql-client -y
sudo systemctl enable postgresql
sudo systemctl start postgresql
sudo systemctl status postgresql
sudo -u postgres psql -c "SELECT version();"
sudo -u postgres psql -c "ALTER USER 'postgres' PASSWORD 'otabek';"
echo -e "${GREEN}Postgres latest installed ${NC}"

echo -e "${RED}Docker  installing${NC}"
sudo apt update && sudo apt dist-upgrade -y
sudo apt install docker.io
sudo chmod 777 /var/run/docker.sock
echo -e "${GREEN}Docker  installed ${NC}"

echo -e "${RED}Redis  installing${NC}"
sudo apt install redis
redis-server --daemonize yes
echo -e "${GREEN}Redis  installed ${NC}"

echo -e "${YELLOW}SUCCESSFULLY ALL INSTALLED${NC}"
echo -e "${GREEN}Google installed ${NC}"
echo -e "${GREEN}JetBrains Toolbox installed ${NC}"
echo -e "${GREEN}Telegram installed ${NC}"
echo -e "${GREEN}Postgres 15 installed${NC}"
echo -e "${GREEN}Postgres latest installed ${NC}"
echo -e "${GREEN}Docker  installed ${NC}"
echo -e "${GREEN}Redis  installed ${NC}"




