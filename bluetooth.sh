

if [ $(id -u) != "0" ]; then
    echo
    echo -e "!! You need to be logged in as \e[101m"!!Superuser!!"\e[0m" "\e[39m to run this script !!" >&2 "\e[0m"
    echo
exit 1
fi
read -p "Are you sure you want to start Bluetooth y/n ? " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi
    echo
    echo -n
    read -t 1
    echo -n -e "\e[39m"!! Starting "\e[34m \e[5m"Bluetooth "\e[25m \e[39m"Manager !!"\e[0m"
    echo
    read -t 1
    echo
    echo -n -e "!! Take the \e[34m"Blue "\e[39m"pill and Enjoy the Ride !! "\e[0m"
    echo
    read -t 1
    echo -n "!! working on it !! "
    echo
    read -t 1
    echo
    echo -n "!! Loading Update !! "
    echo
    read -t 1
    echo
    sudo apt-get update
    echo
    echo -n -e "\e[31m"!! "\e[39m"installing missing drivers  "\e[31m"!! "\e[0m"
    echo
    read -t 2
    echo
sudo apt install bluetooth bluez bluez-tools rfkill
sudo systemctl enable bluetooth
sudo systemctl start bluetooth.service


    echo
    echo -n -e "\e[31m"!! "\e[32m"You re good to "\e[34m \e[5m"Go "\e[25m \e[31m"!! "\e[0m"
    echo
    read -t 1
    echo
exit 1
fi
