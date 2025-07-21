#!/bin/bash

# == VARS ==
GREEN='\033[0;32m'


# == Update & Upgrade ==
echo -e "\t\n updating, upgrading and removing old apps ...\n\n"
sudo apt update
sudo apt full-upgrade -y
sudo apt autoremove -y
echo -e "${GREEN}\t\n Successful...\n\n"


# == Installing apps using APT ==
echo -e "\t\n Installing apps using APT package manager ...\n\n"
sudo apt install -y obs-studio vim htop lsd bat gh zsh fish vlc python3-pip \
  fonts-firacode git v2ray traceroute whois wireshark net-tools virtualbox docker.io \
  micro wine wine32 wine64 wine64-tools iw wifite aircrack-ng bully hashcat hcxdumptool \
  hcxtools macchanger nmap curl wget tmux pipenv ipython3 build-essential cmake vim-nox python3-dev \
  mono-complete golang nodejs openjdk-17-jdk openjdk-17-jre npm python3-venv
echo -e "${GREEN}\t\n Successful...\n\n"


# == Installing apps using snap ==
echo -e "\t\n Installing apps using Snap...\n\n"
sudo snap install telegram-desktop
sudo snap install code --classic
echo -e "${GREEN}\t\n Successful...\n\n"


# == Install python modules using pip ==
echo -e "\t\n Installing python modules...\n\n"
pip3 install django --break-system-packages
pip3 install requests --break-system-packages 
pip3 install numpy --break-system-packages
pip3 install pandas --break-system-packages  
pip3 install pipenv --break-system-packages  
pip3 install pytest --break-system-packages
echo -e "${GREEN}\t\n Successful...\n\n"


# Configs
echo "\t\n Configure fish...\n\n"
chsh -s $(which fish)
sudo chsh -s $(which fish)
echo -e "${GREEN}\t\n Successful...\n\n"


# ZSH Config
echo "\t\n Configure zsh...\n\n"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestionsgit 
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

sed -i "/ZSH_THEME=/d" ~/.zshrc
sed -i "plugins=(" ~/.zshrc

echo "ZSH_THEME=\"powerlevel10k/powerlevel10k\"" >> ~/.zshrc
echo "plugins=(git zsh-autosuggestions zsh-syntax-highlighting)" >> ~/.zshrc

mkdir -p ~/.tools/lst
cp lst/* ~/.tools/lst

chmod +x ~/.tools/lst/sys-update.sh
chmod +x ~/.tools/lst/stools/*.sh

echo "alias ll=\"lsd -l\"" >> ~/.zshrc
echo "alias g=\"git\"" >> ~/.zshrc
echo "alias cat=\"batcat\"" >> ~/.zshrc
echo "alias sys-update=\"bash ~/.tools/lst/sys-update.sh\"" >> ~/.zshrc

# FISH Config
echo "alias ll=\"lsd -l\"" >> ~/.fishrc
echo "alias g=\"git\"" >> ~/.fishrc
echo "alias cat=\"batcat\"" >> ~/.fishrc
echo "alias sys-update=\"bash ~/.tools/lst/sys-update.sh\"" >> ~/.fishrc

echo -e "${GREEN}\t\n Successful...\n\n"

# VIM Config
echo "\t\n Configure vim...\n\n"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp configs/vim_config.vim ~/.vimrc


echo -e "${GREEN}\t\n Successful...\n\n"
echo "run -> vim :PlugInstall"

# Checkout and show dialog
echo -e "\t -> Config telegram, v2ray, gh"
echo -e "${GREEN}\t\n Done.............\n\n"
