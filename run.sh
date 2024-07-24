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

# Install Zsh if it is not installed
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
    else
        echo "Unsupported operating system"
        exit 1
    fi
    set_zsh_default
fi

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

source ~/.zshrc

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

brew install zsh

brew install git fzf bat eza zoxide git-delta neovim vim ripgrep wezterm
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

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
install_rust

# Function to update .zshenv
update_zshenv() {
    if ! grep -q '\. "$HOME/.cargo/env"' "$HOME/.zshenv"; then
        echo '. "$HOME/.cargo/env"' >>"$HOME/.zshenv"
        echo "Added '. \"$HOME/.cargo/env\"' to $HOME/.zshenv"
    else
        echo "Line '. \"$HOME/.cargo/env\"' already exists in $HOME/.zshenv"
    fi
}
update_zshenv

source ~/.zshrc

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

if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    install_packages "$ID"
else
    echo "Cannot determine Linux distribution. /etc/os-release file not found."
    exit 1
fi

install_rust

echo "All packages have been installed successfully."

rm -rf ~/.zshrc 2>/dev/null
rm -rf ~/.config/alacritty 2>/dev/null
rm -rf ~/.config/picom 2>/dev/null
rm -rf ~/.config/backgrounds 2>/dev/null
rm -rf ~/.config/bat 2>/dev/null
rm -rf ~/.config/i3 2>/dev/null
rm -rf ~/.config/nvim 2>/dev/null
rm -rf ~/.config/picom 2>/dev/null
rm -rf ~/.config/polybar 2>/dev/null
rm -rf ~/.config/rofi 2>/dev/null
rm -rf ~/.config/screenlayout 2>/dev/null
rm -rf ~/.config/xresources 2>/dev/null
rm -rf ~/.tmux 2>/dev/null
rm -rf ~/tpm 2>/dev/null
rm -rf ~/.tmux.conf 2>/dev/null
rm -rf ~/fzf-git.sh 2>/dev/null
rm -rf ~/.gitconfig 2>/dev/null
rm -rf ~/.wezterm.lua 2>/dev/null

mkdir ~/.config 2>/dev/null

./symlink.sh "~/dotfiles/config/picom" "~/.config/picom"
./symlink.sh "~/dotfiles/config/backgrounds" "~/.config/backgrounds"
./symlink.sh "~/dotfiles/config/bat" "~/.config/bat"
./symlink.sh "~/dotfiles/config/i3" "~/.config/i3"
./symlink.sh "~/dotfiles/config/i3" "~/.config/i3"
./symlink.sh "~/dotfiles/config/nvim" "~/.config/nvim"
./symlink.sh "~/dotfiles/config/polybar" "~/.config/polybar"
./symlink.sh "~/dotfiles/config/rofi" "~/.config/rofi"
./symlink.sh "~/dotfiles/config/screenlayout" "~/.config/screenlayout"
./symlink.sh "~/dotfiles/config/xresources" "~/.config/xresources"
./symlink.sh "~/dotfiles/tmux/tmux.conf" "~/.tmux.conf"
./symlink.sh "~/dotfiles/tmux/tmux" "~/.tmux"
./symlink.sh "~/dotfiles/tmux/tpm" "~/tpm"
./symlink.sh "~/dotfiles/gitconfig/gitconfig" "~/.gitconfig"
./symlink.sh "~/dotfiles/fzf/fzf-git.sh" "~/fzf-git.sh"

if [[ $os == *"Linux"* ]]; then
    ./symlink.sh "~/dotfiles/zshrc/zshrc" "~/.zshrc"
    ./symlink.sh "~/dotfiles/config/wezterm.lua" "~/.wezterm.lua"
    ./symlink.sh "~/dotfiles/config/alacritty" "~/.config/alacritty"
else
    ./symlink.sh "~/dotfiles/zshrc/maczshrc" "~/.zshrc"
    ./symlink.sh "~/dotfiles/config/macwezterm.lua" "~/.wezterm.lua"
    ./symlink.sh "~/dotfiles/config/macalacritty" "~/.config/alacritty"
fi

shopt -u nocasematch

source ~/.zshrc
