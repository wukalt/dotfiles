#!/bin/bash

sudo apt update
sudo apt full-upgrade -y
sudo apt autoremove -y

sudo apt install -y obs-studio vim htop lsd bat gh zsh fish vlc python3-pip \
  fonts-firacode git v2ray traceroute whois wireshark net-tools virtualbox virtualbox-ext-pack docker.io \
  micro wine wine32 wine64 wine64-tools iw wifite aircrack-ng nmap # more apps 

sudo snap install telegram-desktop
sudo snap install v2raya

pip3 install requests --break-system-packages 
pip3 install django --break-system-packages

chsh -s $(which fish)
sudo chsh -s $(which fish)

echo -e "\t -> Install vscode manually"
echo -e "\t -> Config telegram, v2ray, gh, zsh"

