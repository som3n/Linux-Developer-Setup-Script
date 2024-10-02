#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to display a menu and get user input
function prompt_user() {
    local PROMPT="$1"
    local OPTIONS=("${!2}")
    local CHOICE

    echo "$PROMPT"
    for i in "${!OPTIONS[@]}"; do
        echo "$((i+1))). ${OPTIONS[i]}"
    done
    echo "0). Skip"

    read -p "Enter your choice [0-${#OPTIONS[@]}]: " CHOICE
    if [[ "$CHOICE" -ge 1 && "$CHOICE" -le "${#OPTIONS[@]}" ]]; then
        echo "${OPTIONS[$((CHOICE-1))]}"
    else
        echo "Skip"
    fi
}

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Install essential packages
echo "Installing essential packages..."
sudo apt install -y build-essential curl wget git vim unzip zip

# Install Git
read -p "Do you want to configure Git? (y/n): " CONFIG_GIT
if [[ "$CONFIG_GIT" == "y" || "$CONFIG_GIT" == "Y" ]]; then
    read -p "Enter your Git user name: " GIT_NAME
    read -p "Enter your Git user email: " GIT_EMAIL
    git config --global user.name "$GIT_NAME"
    git config --global user.email "$GIT_EMAIL"
    echo "Git configured with name '$GIT_NAME' and email '$GIT_EMAIL'."
fi

# Programming Languages Installation
declare -a LANGUAGES=("Python" "Java" "Node.js" "Ruby" "Go" "Rust" "C# (.NET)" "PHP" "Perl")

CHOICE_LANG=$(prompt_user "Select a programming language to install:" LANGUAGES[@])

case "$CHOICE_LANG" in
    "Python")
        echo "Installing Python..."
        sudo apt install -y python3 python3-pip python3-venv
        ;;
    "Java")
        echo "Installing Java (OpenJDK)..."
        sudo apt install -y default-jdk
        ;;
    "Node.js")
        echo "Installing Node.js and npm..."
        curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
        sudo apt install -y nodejs
        ;;
    "Ruby")
        echo "Installing Ruby..."
        sudo apt install -y ruby-full
        ;;
    "Go")
        echo "Installing Go..."
        wget https://go.dev/dl/go1.20.5.linux-amd64.tar.gz
        sudo tar -C /usr/local -xzf go1.20.5.linux-amd64.tar.gz
        echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.profile
        source ~/.profile
        rm go1.20.5.linux-amd64.tar.gz
        ;;
    "Rust")
        echo "Installing Rust..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source $HOME/.cargo/env
        ;;
    "C# (.NET)")
        echo "Installing .NET SDK..."
        wget https://packages.microsoft.com/config/debian/$(lsb_release -rs)/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
        sudo dpkg -i packages-microsoft-prod.deb
        sudo apt update
        sudo apt install -y dotnet-sdk-7.0
        rm packages-microsoft-prod.deb
        ;;
    "PHP")
        echo "Installing PHP..."
        sudo apt install -y php php-cli php-fpm
        ;;
    "Perl")
        echo "Installing Perl..."
        sudo apt install -y perl
        ;;
    "Skip")
        echo "Skipping programming languages installation."
        ;;
esac

# Development Platforms & IDEs
declare -a IDEs=("Visual Studio Code" "JetBrains Toolbox" "Sublime Text" "Atom" "Vim" "Emacs")

CHOICE_IDE=$(prompt_user "Select an IDE to install:" IDEs[@])

case "$CHOICE_IDE" in
    "Visual Studio Code")
        echo "Installing Visual Studio Code..."
        wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
        sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
        sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
        sudo apt update
        sudo apt install -y code
        rm packages.microsoft.gpg
        ;;
    "JetBrains Toolbox")
        echo "Installing JetBrains Toolbox..."
        wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.26.1.13334.tar.gz
        tar -xzf jetbrains-toolbox-1.26.1.13334.tar.gz
        ./jetbrains-toolbox-1.26.1.13334/jetbrains-toolbox &
        rm -rf jetbrains-toolbox-1.26.1.13334.tar.gz jetbrains-toolbox-1.26.1.13334
        ;;
    "Sublime Text")
        echo "Installing Sublime Text..."
        wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
        sudo apt install -y apt-transport-https
        echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
        sudo apt update
        sudo apt install -y sublime-text
        ;;
    "Atom")
        echo "Installing Atom..."
        sudo snap install atom --classic
        ;;
    "Vim")
        echo "Installing Vim..."
        sudo apt install -y vim
        ;;
    "Emacs")
        echo "Installing Emacs..."
        sudo apt install -y emacs
        ;;
    "Skip")
        echo "Skipping IDE installation."
        ;;
esac

# Cloud SDKs
declare -a CLOUD_SDKS=("AWS CLI" "Azure CLI" "Google Cloud SDK")

CHOICE_CLOUD=$(prompt_user "Select a Cloud SDK to install:" CLOUD_SDKS[@])

for SDK in $CHOICE_CLOUD; do
    case "$SDK" in
        "AWS CLI")
            echo "Installing AWS CLI..."
            curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
            sudo apt install -y unzip
            unzip awscliv2.zip
            sudo ./aws/install
            rm -rf aws awscliv2.zip
            ;;
        "Azure CLI")
            echo "Installing Azure CLI..."
            curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
            ;;
        "Google Cloud SDK")
            echo "Installing Google Cloud SDK..."
            echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
            curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
            sudo apt update && sudo apt install -y google-cloud-sdk
            ;;
        "Skip")
            echo "Skipping Cloud SDK installation."
            ;;
    esac
done

# Docker Installation
read -p "Do you want to install Docker? (y/n): " INSTALL_DOCKER
if [[ "$INSTALL_DOCKER" == "y" || "$INSTALL_DOCKER" == "Y" ]]; then
    echo "Installing Docker..."
    sudo apt install -y ca-certificates curl gnupg lsb-release
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo usermod -aG docker "$USER"
    echo "Docker installed. You might need to log out and log back in for group changes to take effect."
fi

# Install Docker Compose (if not included above)
read -p "Do you want to install Docker Compose? (y/n): " INSTALL_DOCKER_COMPOSE
if [[ "$INSTALL_DOCKER_COMPOSE" == "y" || "$INSTALL_DOCKER_COMPOSE" == "Y" ]]; then
    echo "Installing Docker Compose..."
    sudo apt install -y docker-compose
fi

# Install Node Version Manager (nvm)
read -p "Do you want to install NVM (Node Version Manager)? (y/n): " INSTALL_NVM
if [[ "$INSTALL_NVM" == "y" || "$INSTALL_NVM" == "Y" ]]; then
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
    source ~/.bashrc
    nvm install --lts
fi

# Install Python Virtual Environment Tools
read -p "Do you want to install Python virtual environment tools? (y/n): " INSTALL_PYTHON_VENV
if [[ "$INSTALL_PYTHON_VENV" == "y" || "$INSTALL_PYTHON_VENV" == "Y" ]]; then
    echo "Installing virtualenv and virtualenvwrapper..."
    sudo pip3 install virtualenv virtualenvwrapper
    echo "export WORKON_HOME=\$HOME/.virtualenvs" >> ~/.bashrc
    echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> ~/.bashrc
    echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
    source ~/.bashrc
fi

# Install Additional Tools
declare -a ADDITIONAL_TOOLS=("Docker" "tmux" "zsh" "Oh My Zsh" "None")

CHOICE_TOOL=$(prompt_user "Select an additional tool to install:" ADDITIONAL_TOOLS[@])

case "$CHOICE_TOOL" in
    "tmux")
        echo "Installing tmux..."
        sudo apt install -y tmux
        ;;
    "zsh")
        echo "Installing zsh..."
        sudo apt install -y zsh
        ;;
    "Oh My Zsh")
        echo "Installing zsh and Oh My Zsh..."
        sudo apt install -y zsh
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        ;;
    "Docker")
        # Docker already handled above
        ;;
    "None")
        echo "Skipping additional tools installation."
        ;;
esac

# Final System Update
echo "Final system update..."
sudo apt update && sudo apt upgrade -y

echo "Development environment setup is complete!"
echo "It's recommended to reboot your system to ensure all changes take effect."
