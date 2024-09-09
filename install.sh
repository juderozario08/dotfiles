shopt -s nocasematch

cd ~/dotfiles
isLinux() {
    if [[ $OSTYPE == linux* ]]; then
        true
    else
        false
    fi
}

isArch() {
    if [[ $(cat /etc/issue) == *arch* ]]; then
        true
    else
        false
    fi
}

isZSH() {
    if [[ $SHELL == *zsh ]]; then
        echo "ZSH Detected..."
        true
    else
        false
    fi
}

install_zsh() {
    if ! command -v zsh &>/dev/null; then
        if isArch; then
            sudo pacman -Syu --noconfirm
            sudo pacman -S --noconfirm zsh
            sudo pacman -S --needed --noconfirm base-devel git man-db mandoc
            cd ~
            git clone https://aur.archlinux.org/yay.git
            cd yay
            makepkg -si --noconfirm
            yay -S --noconfirm wezterm alacritty obsidian discord
            cd ~/dotfiles
        else
            sudo apt update
            sudo apt install -y zsh git
        fi
        echo "Zsh installed"
    fi
}

set_zsh_default() {
    sudo chsh -s /bin/zsh
    chsh -s /bin/zsh
    echo "Zsh set as default shell"
    echo "Please logout and re-login to your system"
    exit
}

# Function to install Rust using rustup
install_rust() {
    if ! command -v rustc &>/dev/null; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        . $HOME/.cargo/env
    else
        rustup update
    fi
    echo "Rust installed"
}

# Installing Homebrew
install_homebrew() {
    if ! command -v brew &>/dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        (
            echo
            echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"'
        ) >>$HOME/.zshrc
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        source ~/.zshrc
    else
        brew update
    fi
    echo "Homebrew Installed"
}

# Installling dependencies
install_dependencies() {
    if isLinux; then
        if isArch; then
            sudo pacman -S --noconfirm fzf bat eza zoxide git-delta neovim vim ripgrep fd tmux gcc lazygit go
            sudo pacman -S --noconfirm picom rofi dmenu i3 polybar xclip
            yay -S --noconfirm font-manager
        else
            sudo apt update
            sudo apt install -y fzf bat eza zoxide git-delta neovim vim ripgrep fd tmux gcc lazygit go xclip
            sudo apt -y picom rofi dmenu i3 polybar
        fi
    else
        brew install --cask alacritty wezterm
    fi
    brew install zsh
    brew install git fzf bat eza zoxide git-delta neovim vim ripgrep fd htop tokei gcc tmux lazygit go gh
    cargo install vivid alacritty
}

if ! isZSH; then
    install_zsh
    set_zsh_default
fi

install_rust
install_homebrew
install_dependencies

if ! command -v ~/.config; then
    echo "Creating the config directory"
    mkdir ~/.config
fi

# Backing up the files
mv ~/.oh-my-zsh ~/.oh-my-zshbak 2>/dev/null
mv ~/.p10k.zsh ~/.p10k.zshbak 2>/dev/null
mv ~/.gitconfig ~/.gitconfigbak 2>/dev/null
mv ~/fzf-git.sh ~/fzf-git.shbak 2>/dev/null
# Getting the files from repo
cp -r ~/dotfiles/oh-my-zsh ~/.oh-my-zsh
cp -r ~/dotfiles/p10k.zsh ~/.p10k.zsh
cp -r ~/dotfiles/gitconfig/gitconfig ~/.gitconfig
cp -r ~/dotfiles/fzf/fzf-git.sh ~/fzf-git.sh

# Backing up the files
mv ~/.zshrc ~/.zshrcbak 2>/dev/null
mv ~/.wezterm.lua ~/.wezterm.luabak 2>/dev/null
mv ~/.bashrc ~/.bashrcbak 2>/dev/null
mv ~/.bash_profile ~/.bash_profilebak 2>/dev/null
# Getting the files from repo
cp -r ~/dotfiles/zshrc/bashrc ~/.bashrc
cp -r ~/dotfiles/zshrc/bash_profile ~/.bash_profile
cp -r ~/dotfiles/zshrc/zshenv ~/.zshenv

# Backing up the files
mv ~/.config/alacritty ~/.config/alacrittybak 2>/dev/null
mv ~/.config/picom ~/.config/picombak 2>/dev/null
mv ~/.config/backgrounds ~/.config/backgroundsbak 2>/dev/null
mv ~/.config/bat ~/.config/batbak 2>/dev/null
mv ~/.config/i3 ~/.config/i3bak 2>/dev/null
mv ~/.config/nvim ~/.config/nvimbak 2>/dev/null
mv ~/.config/picom ~/.config/picombak 2>/dev/null
mv ~/.config/polybar ~/.config/polybarbak 2>/dev/null
mv ~/.config/rofi ~/.config/rofibak 2>/dev/null
mv ~/.config/screenlayout ~/.config/screenlayoutbak 2>/dev/null
mv ~/.config/xresources ~/.config/xresourcesbak 2>/dev/null
# Getting the files from repo
cp -r ~/dotfiles/config/picom ~/.config/
cp -r ~/dotfiles/config/backgrounds ~/.config/
cp -r ~/dotfiles/config/bat ~/.config/
cp -r ~/dotfiles/config/i3 ~/.config/
cp -r ~/dotfiles/config/nvim ~/.config/
cp -r ~/dotfiles/config/polybar ~/.config/
cp -r ~/dotfiles/config/rofi ~/.config/
cp -r ~/dotfiles/config/screenlayout ~/.config/
cp -r ~/dotfiles/config/xresources ~/.config/

# Backing up the files
mv ~/.tmux ~/.tmuxbak 2>/dev/null
mv ~/.tmux.conf ~/.tmux.confbak 2>/dev/null
mv ~/tpm ~/tpmbak 2>/dev/null
# Getting the files from repo
cp -r ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
cp -r ~/dotfiles/tmux/tmux ~/.tmux
cp -r ~/dotfiles/tmux/tpm ~/tpm

if isLinux; then
    cp -r ~/dotfiles/zshrc/zshrc ~/.zshrc
    cp -r ~/dotfiles/config/wezterm.lua ~/.wezterm.lua
    cp -r ~/dotfiles/config/alacritty ~/.config/
    ~/dotfiles/symlink.sh ~/dotfiles/zshrc/zshrc ~/.zshrc
    ~/dotfiles/symlink.sh ~/dotfiles/config/wezterm.lua ~/.wezterm.lua
    ~/dotfiles/symlink.sh ~/dotfiles/config/alacritty ~/.config/alacritty
else
    cp -r ~/dotfiles/zshrc/maczshrc ~/.zshrc
    cp -r ~/dotfiles/config/macwezterm.lua ~/.wezterm.lua
    cp -r ~/dotfiles/config/macalacritty ~/.config/alacritty
    ~/dotfiles/symlink.sh ~/dotfiles/zshrc/maczshrc ~/.zshrc
    ~/dotfiles/symlink.sh ~/dotfiles/config/macwezterm.lua ~/.wezterm.lua
    ~/dotfiles/symlink.sh ~/dotfiles/config/macalacritty ~/.config/alacritty
fi

~/dotfiles/symlink.sh ~/dotfiles/config/picom ~/.config/picom
~/dotfiles/symlink.sh ~/dotfiles/config/backgrounds ~/.config/backgrounds
~/dotfiles/symlink.sh ~/dotfiles/config/bat ~/.config/bat
~/dotfiles/symlink.sh ~/dotfiles/config/i3 ~/.config/i3
~/dotfiles/symlink.sh ~/dotfiles/config/nvim ~/.config/nvim
~/dotfiles/symlink.sh ~/dotfiles/config/polybar ~/.config/polybar
~/dotfiles/symlink.sh ~/dotfiles/config/rofi ~/.config/rofi
~/dotfiles/symlink.sh ~/dotfiles/config/screenlayout ~/.config/screenlayout
~/dotfiles/symlink.sh ~/dotfiles/config/xresources ~/.config/xresources
~/dotfiles/symlink.sh ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
~/dotfiles/symlink.sh ~/dotfiles/tmux/tmux ~/.tmux
~/dotfiles/symlink.sh ~/dotfiles/tmux/tpm ~/tpm
~/dotfiles/symlink.sh ~/dotfiles/zshrc/bashrc ~/.bashrc
~/dotfiles/symlink.sh ~/dotfiles/zshrc/bash_profile ~/.bash_profile
~/dotfiles/symlink.sh ~/dotfiles/OHMYZSHCUSTOM ~/.oh-my-zsh
~/dotfiles/symlink.sh ~/dotfiles/p10k.zsh ~/.p10k.zsh
~/dotfiles/symlink.sh ~/dotfiles/gitconfig/gitconfig ~/.gitconfig

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

source ~/.zshrc

shop -u nocasematch
