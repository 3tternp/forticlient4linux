#!/usr/bin/bash

# Function to install FortiClient on Debian

install_forticlient_debian() {
    echo "Adding Debian repository..."
    echo "deb http://ftp.debian.org/debian stable main contrib non-free" | sudo tee -a /etc/apt/sources.list

    echo "Updating package list..."
    sudo apt update -y

    echo "Installing required dependencies..."
    sudo apt install libdbusmenu-gtk4 -y

    echo "Downloading necessary .deb packages..."
    wget http://ftp.cn.debian.org/debian/pool/main/libi/libindicator/libindicator7_0.5.0-4_amd64.deb
    wget http://ftp.cn.debian.org/debian/pool/main/liba/libappindicator/libappindicator1_0.4.92-7_amd64.deb
    wget https://filestore.fortinet.com/forticlient/forticlient_vpn_7.4.0.1636_amd64.deb

    echo "Installing downloaded packages..."
    sudo dpkg -i libindicator7_0.5.0-4_amd64.deb
    sudo dpkg -i libappindicator1_0.4.92-7_amd64.deb
    sudo dpkg -i forticlient_vpn_7.4.0.1636_amd64.deb

    echo "Fixing missing dependencies..."
    sudo apt --fix-broken install -y

    echo "FortiClient installed on Debian successfully!"
}

# Function to install FortiClient on Ubuntu

install_forticlient_ubuntu() {
    echo "Adding Fortinet repository for Ubuntu..."
    wget -O - https://repo.fortinet.com/repo/forticlient/7.4/ubuntu22/DEB-GPG-KEY | gpg --dearmor | sudo tee /usr/share/keyrings/repo.fortinet.com.gpg

    echo "Adding repository to sources.list..."
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/repo.fortinet.com.gpg] https://repo.fortinet.com/repo/forticlient/7.4/ubuntu22/ stable non-free" | sudo tee /etc/apt/sources.list.d/fortinet.list

    echo "Updating package list..."
    sudo apt update -y

    echo "Installing required dependencies..."
    sudo apt install libindicator7 libappindicator1 libdbusmenu-gtk4 -y

    echo "Installing FortiClient..."
    sudo apt install forticlient -y

    echo "FortiClient installed on Ubuntu successfully!"
}

# Main script starts here
echo "Choose the option:"
echo "1. Install FortiClient on Debian"
echo "2. Install FortiClient on Ubuntu"
read -p "Enter your choice (1 or 2): " user_choice

if [ "$user_choice" -eq 1 ]; then
    install_forticlient_debian
elif [ "$user_choice" -eq 2 ]; then
    install_forticlient_ubuntu
else
    echo "Invalid choice. Exiting script."
    exit 1
fi

