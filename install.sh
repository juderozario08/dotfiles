#!/bin/bash

# brew setup
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.zshrc
source ~/.zshrc

# cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
. "$HOME/.cargo/env"

#dependencies
sudo pacman -S --needed git base-devel
cd ~

sudo pacman -S fd ripgrep npm eza zoxide htop tokei tree bat fzf lazygit tmux --noconfirm
brew install fd ripgrep npm eza zoxide htop tokei tree bat fzf zsh gh tmux
cargo install alacritty vivid
yay -S wezterm-git alacritty webcord spotify obsidian obs-studio zen-browser-bin firefox
yay -S dconf dunst fastfetch gtk3 gtk4 hyprland nautilus pavucontrol
yay -S pulse qt6ct rofi starship systemd waybar wal wlogout xsettingsd sddm

cd ~
git clone https://github.com/junegunn/fzf-git.sh

source ~/.zshrc

sudo pacman -Syu --noconfirm
yay -Syu --noconfirm

gh auth login
