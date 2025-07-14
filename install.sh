#!/bin/bash

# Update & Upgrade
sudo apt update
sudo apt full-upgrade -y
sudo apt autoremove -y

# Installing apps using APT
sudo apt install -y obs-studio vim htop lsd bat gh zsh fish vlc python3-pip \
  fonts-firacode git v2ray traceroute whois wireshark net-tools virtualbox docker.io \
  micro wine wine32 wine64 wine64-tools iw wifite aircrack-ng bully hashcat hcxdumptool \
  hcxtools macchanger nmap curl wget tmux pipenv

# Installing apps using snap
sudo snap install telegram-desktop
sudo snap install v2raya
sudo snap install code --classic

# Install python modules using pip
pip3 install django --break-system-packages
pip3 install requests --break-system-packages 
pip3 install numpy --break-system-packages
pip3 install pandas --break-system-packages  
pip3 install pipenv --break-system-packages  

# Configs
chsh -s $(which fish)
sudo chsh -s $(which fish)

  # ZSH Config
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
  git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestionsgit 
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
  echo -e "set -> ZSH_THEME="powerlevel10k/powerlevel10k"
  echo -e "set -> plugins=(git zsh-autosuggestions zsh-syntax-highlighting)"

  echo "alias ll=\"lsd -l\"" >> ~/.zshrc
  echo "alias g=\"git\"" >> ~/.zshrc
  echo "alias cat=\"batcat\"" >> ~/.zshrc

  # VIM Config
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  cp vim_config.vim ~/.vimrc
  
  echo "run -> vim :PlugInstall"

# Checkout and show dialog
echo -e "\t -> Install vscode manually"
echo -e "\t -> Config telegram, v2ray, gh, zsh"

