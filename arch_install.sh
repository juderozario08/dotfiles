#!/bin/bash

set -e

remove_path_if_exists() {
    if [ -e "$1" ]; then
        rm -rf "$1"
    fi
}
link_path() {
    ln -s "$1" "$2"
}

gain_sudo() {
    echo "Requesting sudo privileges..."
    if sudo -v; then
        echo "Sudo privileges granted"
    else
        echo "Failed to get sudo perms" >&2
        exit 1
    fi
}

install_rust() {
    if ! command -v cargo >/dev/null 2>&1; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        source "$HOME"/.cargo/env
    fi
}

install_yay() {
    if ! command -v yay >/dev/null 2>&1; then
        cd "$HOME"
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si
        cd ..
        rm -rf yay
    fi
}

install_dependencies() {
    yay -Syu --needed git base-devel fd ripgrep npm eza zoxide btop tokei bat fzf zsh tmux deno alacritty firefox paru \
        pyenv vivid inetutils nwg-look man-db man-pages gtk3 gtk4 picom nautilus pavucontrol sddm usleep lazygit font-manager \
        i3-wm hyprland obsidian obs-studio sddm-sugar-dark mpvpaper betterlockscreen systemd gnome-tweaks usleep \
        lxappearance spotify bash-pipes blueman polybar rofi maim xclip ttf-firacode-nerd lua luarocks vesktop \
        hyprpaper hyprlock hypridle hyprshot grim swaync wezterm-nightly-bin hyprcursor xdg-desktop-portal-hyprland \
        qt6-svg qt6-virtualkeyboard qt6-multimedia-ffmpeg gum eog --noconfirm

    if [ ! -e "$HOME/fzf-git.sh" ]; then
        cd ~
        git clone https://github.com/junegunn/fzf-git.sh
        cd ~/dotfiles
    fi
}

setup_sddm() {
    sudo git clone -b master --depth 1 https://github.com/keyitdev/sddm-astronaut-theme.git /usr/share/sddm/themes/sddm-astronaut-theme
    sudo mkdir -p /etc/sddm.conf.d

    sudo cp -r /usr/lib/sddm/sddm.conf.d/default.conf /etc/sddm.conf.d/
    sudo cp -r /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/
    echo "[Theme]
    Current=sddm-astronaut-theme" | sudo tee /etc/sddm.conf.d/default.conf
    echo "[General]
    InputMethod=qtvirtualkeyboard" | sudo tee /etc/sddm.conf.d/virtualkbd.conf

    sudo cp ./wallpaper/videos/Nier-4K.mp4 /usr/share/sddm/themes/sddm-astronaut-theme/Backgrounds/
    sudo cp ./sddm-theme/custom.conf /usr/share/sddm/themes/sddm-astronaut-theme/Themes/
    sudo cp ./sddm-theme/metadata.desktop /usr/share/sddm/themes/sddm-astronaut-theme/

}

link_dots() {
    remove_path_if_exists "$HOME/.bashrc"
    remove_path_if_exists "$HOME/.bashrc"
    remove_path_if_exists "$HOME/.zshrc"
    remove_path_if_exists "$HOME/.icons"
    remove_path_if_exists "$HOME/.themes"
    remove_path_if_exists "$HOME/.tmux.conf"
    remove_path_if_exists "$HOME/.tmux"
    remove_path_if_exists "$HOME/.vimrc"
    remove_path_if_exists "$HOME/.wezterm.lua"
    remove_path_if_exists "$HOME/.gitconfig"
    remove_path_if_exists "$HOME/wallpaper"
    remove_path_if_exists "$HOME/.Xresources"

    link_path "$HOME/dotfiles/.bashrc" "$HOME/.bashrc"
    link_path "$HOME/dotfiles/.zshrc" "$HOME/.zshrc"
    link_path "$HOME/dotfiles/.icons" "$HOME/.icons"
    link_path "$HOME/dotfiles/.themes" "$HOME/.themes"
    link_path "$HOME/dotfiles/.tmux.conf" "$HOME/.tmux.conf"
    link_path "$HOME/dotfiles/.tmux" "$HOME/.tmux"
    link_path "$HOME/dotfiles/tpm" "$HOME/tpm"
    link_path "$HOME/dotfiles/.vimrc" "$HOME/.vimrc"
    link_path "$HOME/dotfiles/.wezterm.lua" "$HOME/.wezterm.lua"
    link_path "$HOME/dotfiles/.gitconfig" "$HOME/.gitconfig"
    link_path "$HOME/dotfiles/wallpaper" "$HOME/wallpaper"
    link_path "$HOME/dotfiles/.Xresources" "$HOME/.Xresources"
    link_path "$HOME/dotfiles/.gtkrc-2.0" "$HOME/.gtkrc-2.0"

    for i in $(/bin/ls -a "$HOME"/dotfiles/config | tail -n +3); do
        remove_path_if_exists "$HOME/.config/${i}"
        link_path "${HOME}/dotfiles/config/${i}" "$HOME/.config/$i"
    done
}

setup_rofi() {
    sudo cp "$HOME"/.config/rofi/colors/tokyonight.rasi /usr/share/rofi/themes/
    sudo cp "$HOME"/.config/rofi/colors/catppuccin.rasi /usr/share/rofi/themes/
    sudo cp "$HOME"/.config/rofi/colors/cyberpunk.rasi /usr/share/rofi/themes/
    "$HOME"/dotfiles/rofiFonts/setup.sh
}

setup_vesktop() {
    if [ -e "$HOME/.config/vesktop/themes" ]; then
        cp "$HOME/dotfiles/vesktopThemes/*" "$HOME/.config/vesktop/themes/"
    fi
}

gain_sudo
install_rust
install_yay
install_dependencies
link_dots
setup_sddm
setup_vesktop

sudo pacman -Syu --noconfirm && yay -Syu --noconfirm

if [[ "$(echo "$SHELL" | grep zsh)" ]]; then
    source "$HOME"/.zshrc
else
    chsh -s /bin/zsh
    echo "Please close and reopen the terminal. Or logout and log back int to the session for the SHELL change to take affect!"
fi

sudo -k
