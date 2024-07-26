shopt -s nocasematch
git clone https://github.com/juderozario08/TMUClub.git ~/ 2>/dev/null
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
            sudo pacman -S --needed --noconfirm base-devel git mandb
            cd ~
            git clone https://aur.archlinux.org/yay.git
            cd yay
            makepkg -si --noconfirm
            yay -S --noconfirm wezterm
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
    echo "Please logout and re-login or restart your system and then re-run this script"
    exit
}

# Function to install Rust using rustup
install_rust() {
    if ! command -v rustc &>/dev/null; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        echo '. "$HOME/.cargo/env"' >>~/.zshrc
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
            sudo pacman -S --noconfirm fzf bat eza zoxide git-delta neovim vim ripgrep fd tmux gcc lazygit
        else
            sudo apt update
            sudo apt install -y fzf bat eza zoxide git-delta neovim vim ripgrep fd tmux gcc lazygit
        fi
    else
        brew install --cask alacritty
    fi
    brew install zsh
    brew install git fzf bat eza zoxide git-delta neovim vim ripgrep wezterm fd htop tokei gcc tmux lazygit
    cargo install vivid alacritty
}

if ! isZSH; then
    install_zsh
    set_zsh_default
fi

install_rust
install_homebrew
install_dependencies

mv ~/.zshrc ~/.zshrcbak 2>/dev/null
mv ~/.wezterm.lua ~/.wezterm.luabak 2>/dev/null
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
mv ~/.tmux ~/.tmuxbak 2>/dev/null
mv ~/.tmux.conf ~/.tmux.confbak 2>/dev/null
mv ~/.bashrc ~/.bashrcbak 2>/dev/null
mv ~/.bash_profile ~/.bash_profilebak 2>/dev/null
mv ~/.oh-my-zsh ~/.oh-my-zshbak 2>/dev/null
mv ~/.p10k.zsh ~/.p10k.zshbak 2>/dev/null

rm -rf ~/tpm 2>/dev/null
rm -rf ~/.gitconfig 2>/dev/null
rm -rf ~/fzf-git.sh 2>/dev/null

cp -r ~/dotfiles/oh-my-zsh ~/.oh-my-zsh
cp -r ~/dotfiles/p10k.zsh ~/.p10k.zsh
cp -r ~/dotfiles/zshrc/bashrc ~/.bashrc
cp -r ~/dotfiles/zshrc/bash_profile ~/.bash_profile

mkdir ~/.config 2>/dev/null

./symlink.sh "~/dotfiles/config/picom" "~/.config/picom"
./symlink.sh "~/dotfiles/config/backgrounds" "~/.config/backgrounds"
./symlink.sh "~/dotfiles/config/bat" "~/.config/bat"
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

if ! isLinux; then
    ./symlink.sh "~/dotfiles/zshrc/maczshrc" "~/.zshrc"
    ./symlink.sh "~/dotfiles/config/macwezterm.lua" "~/.wezterm.lua"
    ./symlink.sh "~/dotfiles/config/macalacritty" "~/.config/alacritty"
else
    ./symlink.sh "~/dotfiles/zshrc/zshrc" "~/.zshrc"
    ./symlink.sh "~/dotfiles/config/wezterm.lua" "~/.wezterm.lua"
    ./symlink.sh "~/dotfiles/config/alacritty" "~/.config/alacritty"
fi

shopt -u nocasematch
source ~/.zshrc

echo "Dotfiles Installation Complete"
