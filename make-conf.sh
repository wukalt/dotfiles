#!/bin/bash
set -e

# --- Detect OS ---
if [ -f /etc/debian_version ]; then
    OS="debian"
elif [ -f /etc/arch-release ]; then
    OS="arch"
else
    echo "❌ Unsupported distro"
    exit 1
fi

echo "➡️ Detected OS: $OS"

# --- Debian/Ubuntu setup ---
if [ "$OS" = "debian" ]; then
    echo "🔧 Updating system..."
    sudo apt update
    sudo apt full-upgrade -y
    sudo apt autoremove -y

    # Enable 32-bit arch for wine
    sudo dpkg --add-architecture i386
    sudo apt update

    echo "📦 Installing packages..."
    sudo apt install -y \
      obs-studio vim htop lsd bat gh zsh fish vlc python3-pip \
      fonts-firacode git traceroute whois wireshark net-tools virtualbox docker.io \
      micro wine wine32 wine64 wine64-tools iw wifite aircrack-ng bully hashcat hcxdumptool \
      hcxtools macchanger nmap curl wget tmux pipenv ipython3 build-essential cmake vim-nox python3-dev \
      mono-complete golang openjdk-17-jdk openjdk-17-jre python3-venv

    echo "📦 Installing snaps..."
    sudo snap install telegram-desktop
fi

# --- Arch/Manjaro setup ---
if [ "$OS" = "arch" ]; then
    echo "🔧 Updating system..."
    sudo pacman -Syu --noconfirm

    echo "📦 Installing base packages..."
    sudo pacman -S --noconfirm --needed \
      base-devel git curl wget htop vim tmux \
      python python-pip ipython go \
      jdk17-openjdk jre17-openjdk \
      docker docker-compose \
      wireshark-qt net-tools traceroute whois nmap \
      vlc virtualbox \
      mono \
      cmake make gcc \
      zsh fish \
      aircrack-ng hashcat macchanger iw \
      obs-studio uget

    # Install yay if missing
    if ! command -v yay &> /dev/null; then
        echo "📦 Installing yay..."
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay
        makepkg -si --noconfirm
        cd -
    fi

    echo "📦 Installing AUR packages..."
    yay -S --noconfirm --needed \
      lsd bat micro v2ray \
      wifite hcxtools hcxdumptool bully \
      telegram-desktop 
fi

# --- Python packages (common) ---
echo "🐍 Installing Python packages..."
pip install django requests numpy pandas pipenv pytest --break-system-packages || true

# --- Configure vim ---
echo -e "\n📝 Configuring vim...\n"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp configs/vim_config.vim ~/.vimrc 2>/dev/null || true

echo -e "\n✅ All done!"
echo -e "➡️ Run :PlugInstall inside vim"
echo -e "➡️ Configure telegram, v2ray, gh manually"
