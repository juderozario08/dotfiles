#!/bin/bash

shell="$SHELL"
os=$(uname)
shopt -s nocasematch

install_zsh() {
    echo "Installing Zsh..."
    if ! $1; then
        echo "Failed to install Zsh. Please install it manually."
        exit 1
    fi
}

set_zsh_default() {
    echo "Do you want to set Zsh as your default shell? (y/n)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
        chsh -s $(which zsh)
    fi
}

if [[ $shell != *"zsh"* ]]; then
    if [[ $os == *"Linux"* ]]; then
        if [[ -f /etc/os-release ]]; then
            . /etc/os-release
            case $ID in
            arch)
                echo "Arch Linux detected"
                install_zsh "sudo pacman -S zsh"
                ;;
            ubuntu | debian)
                echo "${ID^} detected"
                install_zsh "sudo apt install zsh"
                ;;
            fedora)
                echo "Fedora detected"
                install_zsh "sudo dnf install zsh"
                ;;
            centos)
                echo "CentOS detected"
                install_zsh "sudo yum install zsh"
                ;;
            opensuse* | suse)
                echo "openSUSE detected"
                install_zsh "sudo zypper install zsh"
                ;;
            *)
                echo "Unsupported Linux distribution: $ID"
                exit 1
                ;;
            esac
        else
            echo "Cannot determine Linux distribution. /etc/os-release file not found."
            exit 1
        fi
    elif [[ $os == *"Darwin"* ]]; then
        echo "MacOS detected"
        install_zsh "brew install zsh"
    else
        echo "Unsupported operating system"
        exit 1
    fi

    set_zsh_default
else
    echo "Zsh is already your default shell."
fi

# Homebrew installation and update
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ $os == *"Darwin"* ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ $os == *"Linux"* ]]; then
        echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/.profile
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
else
    echo "Updating Homebrew"
    brew update
fi

echo "ZSH installation complete"

brew install git fzf bat eza zoxide git-delta neovim vim ripgrep wezterm
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install vivid alacritty
install_packages() {
    case $1 in
    arch)
        sudo pacman -S --noconfirm git fzf bat eza zoxide git-delta neovim vim ripgrep wezterm
        ;;
    ubuntu | debian)
        sudo apt update
        sudo apt install -y git fzf bat eza zoxide git-delta neovim vim ripgrep wezterm
        ;;
    fedora)
        sudo dnf install -y git fzf bat eza zoxide git-delta neovim vim ripgrep wezterm
        ;;
    centos)
        sudo yum install -y epel-release
        sudo yum install -y git fzf bat eza zoxide git-delta neovim vim ripgrep wezterm
        ;;
    opensuse* | suse)
        sudo zypper install -y git fzf bat eza zoxide git-delta neovim vim ripgrep wezterm
        ;;
    *)
        echo "Unsupported Linux distribution: $1"
        exit 1
        ;;
    esac
}

# Function to install Rust using rustup
install_rust() {
    if ! command -v rustup &>/dev/null; then
        echo "Installing Rust..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        echo "Rust installed successfully."
    else
        echo "Rust is already installed."
    fi
}

# Function to update .zshenv
update_zshenv() {
    if ! grep -q '\. "$HOME/.cargo/env"' "$HOME/.zshenv"; then
        echo '. "$HOME/.cargo/env"' >>"$HOME/.zshenv"
        echo "Added '. \"$HOME/.cargo/env\"' to $HOME/.zshenv"
    else
        echo "Line '. \"$HOME/.cargo/env\"' already exists in $HOME/.zshenv"
    fi
}

if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    install_packages "$ID"
else
    echo "Cannot determine Linux distribution. /etc/os-release file not found."
    exit 1
fi

install_rust
update_zshenv

echo "All packages have been installed successfully."
shopt -u nocasematch

rm -rf ~/.zshrc
eval "./symlink.sh ~/dotfiles/zshrc/.maczshrc ~/.zshrc"

rm -rf ~/.config/alacritty
eval "./symlink.sh ~/dotfiles/config/macalacritty ~/.config/alacritty"
