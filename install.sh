#!/bin/bash

# ZSH setup
sudo pacman -S zsh --noconfirm
if [ -z "$(echo $SHELL | grep zsh)" ]; then
    chsh -s /bin/zsh
fi

# brew setup
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"'
source ~/.zshrc

# Custom ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
. "$HOME/.cargo/env"

#dependencies
sudo pacman -S fd ripgrep npm eza zoxide htop tokei tree bat fzf lazygit --noconfirm
brew install fd ripgrep npm eza zoxide htop tokei tree bat fzf zsh
cargo install alacritty vivid
yay -S discord spotify obsidian obs-studio zen-browser-bin --noconfirm

#symlinks
~/dotfiles/symlink.sh ~/dotfiles/config/nvim ~/.config/nvim
~/dotfiles/symlink.sh ~/dotfiles/config/bat ~/.config/bat
~/dotfiles/symlink.sh ~/dotfiles/config/kitty ~/.config/kitty
~/dotfiles/symlink.sh ~/dotfiles/config/picom ~/.config/picom
~/dotfiles/symlink.sh ~/dotfiles/config/backgrounds ~/.config/backgrounds
~/dotfiles/symlink.sh ~/dotfiles/config/wezterm.lua ~/.wezterm.lua
~/dotfiles/symlink.sh ~/dotfiles/config/alacritty ~/.config/alacritty
~/dotfiles/symlink.sh ~/dotfiles/tmux/tmux ~/.tmux
~/dotfiles/symlink.sh ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
~/dotfiles/symlink.sh ~/dotfiles/tmux/tpm ~/tpm

cp -r ~/dotfiles/gitconfig/gitconfig ~/.gitconfig

rm ~/.zshrc
cp -r ~/dotfiles/zshrc/zshrc ~/.zshrc
cp -r ~/dotfiles/zshrc/zshenv ~/.zshenv
cp -r ~/dotfiles/zshrc/bash_profile ~/.bash_profile
cp -r ~/dotfiles/zshrc/bashrc ~/.bashrc

cd ~
git clone https://github.com/junegunn/fzf-git.sh

source ~/.zshrc
