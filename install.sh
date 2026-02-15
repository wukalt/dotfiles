#!/bin/bash
set -e

echo -e "🔧 Updating system..."
sudo apt update
sudo apt full-upgrade -y
sudo apt autoremove -y
sudo dpkg --add-architecture i386
sudo apt update

echo "📦 Installing packages..."
sudo apt install -y \
  obs-studio vim htop lsd bat gh fish vlc python3-pip code\
  fonts-firacode git traceroute whois wireshark net-tools virtualbox docker.io \
  micro wine wine32 wine64 wine64-tools iw wifite aircrack-ng bully hashcat hcxdumptool \
  hcxtools macchanger nmap curl wget tmux pipenv ipython3 build-essential cmake vim-nox python3-dev \
  mono-complete golang openjdk-17-jdk openjdk-17-jre python3-venv \
  libreoffice-impress libreoffice-base libreoffice-draw libreoffice-writer libreoffice-math libreoffice-calc libreoffice-style-colibre \
  libreoffice-gtk3 arc-themes

sudo snap install telegram-desktop


mkdir -p ~/tmp ~/.icons ~/.themes ~/Pictures/Backgrounds ~/Projects ~/.tools

git clone https://github.com/daniruiz/flat-remix.git ~/tmp
mv ~/tmp/Flat-Remix-Blue-Dark ~/.icons

curl -fsSL https://raw.githubusercontent.com/render-oss/cli/refs/heads/main/bin/install.sh | sh

pip install "fastapi[standard]" django requests pytest --break-system-packages || true

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp configs/vim_config.vim ~/.vimrc 2>/dev/null || true


mv configs/chdns.sh ~/.tools
echo "alias chdns=\"sudo source ~/.tools/chdns.sh\"" >> ~/.fishrc
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
chsh -s $(which fish)
sudo chsh -s $(which fish)


xfwm4-settings
xfce4-appearance-settings
xfce4-settings-editor
xfce4-mouse-settings
xfce4-power-manager-settings
render login
vim
gh auth login


rm -rf ~/tmp


echo -e "\n✅ All done!"
echo -e "➡️ Configure telegram, v2ray"
