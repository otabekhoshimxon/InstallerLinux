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

