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
      fonts-firacode git v2ray traceroute whois wireshark net-tools virtualbox docker.io \
      micro wine wine32 wine64 wine64-tools iw wifite aircrack-ng bully hashcat hcxdumptool \
      hcxtools macchanger nmap curl wget tmux pipenv ipython3 build-essential cmake vim-nox python3-dev \
      mono-complete golang nodejs npm openjdk-17-jdk openjdk-17-jre python3-venv

    echo "📦 Installing snaps..."
    sudo snap install telegram-desktop
    sudo snap install code --classic
fi

# --- Arch/Manjaro setup ---
if [ "$OS" = "arch" ]; then
    echo "🔧 Updating system..."
    sudo pacman -Syu --noconfirm

    echo "📦 Installing base packages..."
    sudo pacman -S --noconfirm --needed \
      base-devel git curl wget htop vim tmux \
      python python-pip ipython \
      go nodejs npm \
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
      telegram-desktop visual-studio-code-bin
fi

# --- Python packages (common) ---
echo "🐍 Installing Python packages..."
pip install django requests numpy pandas pipenv pytest --break-system-packages || true

# --- Configure fish ---
echo -e "\n🐟 Configuring fish...\n"
mkdir -p ~/.config/fish
cat >> ~/.config/fish/config.fish <<EOF
alias ll="lsd -l"
alias g="git"
alias cat="bat"
alias sys-update="$( [ "$OS" = "arch" ] && echo "sudo pacman -Syu" || echo "bash ~/.tools/lst/sys-update.sh" )"
alias chdns="bash ~/.tools/lst/stools/chdns.sh"
EOF
chsh -s $(which fish)
sudo chsh -s $(which fish)

# --- Configure zsh ---
echo -e "\n💻 Configuring zsh...\n"
export ZSH="$HOME/.oh-my-zsh"
if [ ! -d "$ZSH" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k || true
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting || true

sed -i '/^ZSH_THEME=/d' ~/.zshrc
echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> ~/.zshrc

sed -i '/^plugins=/d' ~/.zshrc
echo 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting)' >> ~/.zshrc

cat >> ~/.zshrc <<EOF
alias ll="lsd -l"
alias g="git"
alias cat="bat"
alias sys-update="$( [ "$OS" = "arch" ] && echo "sudo pacman -Syu" || echo "bash ~/.tools/lst/sys-update.sh" )"
alias chdns="bash ~/.tools/lst/stools/chdns.sh"
EOF

# --- Custom tools ---
mkdir -p ~/.tools/lst
cp -r lst/* ~/.tools/lst/ 2>/dev/null || true
chmod +x ~/.tools/lst/sys-update.sh 2>/dev/null || true
chmod +x ~/.tools/lst/stools/*.sh 2>/dev/null || true

# --- Configure vim ---
echo -e "\n📝 Configuring vim...\n"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp configs/vim_config.vim ~/.vimrc 2>/dev/null || true

echo -e "\n✅ All done!"
echo -e "➡️ Run :PlugInstall inside vim"
echo -e "➡️ Configure telegram, v2ray, gh manually"
