#!/bin/bash

# brew setup
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.zshrc
source ~/.zshrc

# cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
. "$HOME/.cargo/env"

#dependencies
sudo pacman -S --needed git base-devel
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

sudo pacman -S fd ripgrep npm eza zoxide htop tokei tree bat fzf lazygit tmux btop --noconfirm
brew install fd ripgrep npm eza zoxide htop tokei tree bat fzf zsh gh tmux
cargo install alacritty vivid
yay -S gtk3 gtk4 hyprland nautilus pavucontrol pulse qt6ct rofi starship systemd waybar wlogout xsettingsd sddm hyprpaper hyprlock hypridle hyprshot swaync wezterm-git alacritty webcord obsidian obs-studio zen-browser-bin sddm-sugar-dark --noconfirm

cd ~
git clone https://github.com/junegunn/fzf-git.sh

sudo pacman -Syu --noconfirm
yay -Syu --noconfirm
