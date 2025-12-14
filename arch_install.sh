#!/bin/zsh

set -e

echo "Requesting sudo privileges..."
if sudo -v; then
    echo "Sudo privileges granted"
else
    echo "Failed to get sudo perms" >&2
    exit 1
fi

if ! command -v cargo >/dev/null 2>&1; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "$HOME"/.cargo/env
fi

if ! command -v yay >/dev/null 2>&1; then
    cd "$HOME"
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay
fi

yay -Syu --needed git base-devel fd ripgrep npm eza zoxide btop tokei bat fzf zsh tmux deno alacritty firefox paru \
    pyenv vivid inetutils nwg-look man-db man-pages gtk3 gtk4 picom nautilus pavucontrol sddm usleep lazygit font-manager \
    i3-wm hyprland obsidian obs-studio sddm-sugar-dark mpvpaper betterlockscreen systemd gnome-tweaks usleep \
    lxappearance spicetify-cli bash-pipes blueman polybar rofi maim xclip ttf-firacode-nerd lua luarocks vesktop \
    hyprpaper hyprlock hypridle hyprshot grim swaync wezterm-nightly-bin hyprcursor --noconfirm

if [ ! -d "$HOME/fzf-git.sh" ]; then
    cd ~
    git clone https://github.com/junegunn/fzf-git.sh
    cd ~/dotfiles
fi

rm -rf "$HOME/.bashrc" #&&
rm -rf "$HOME/.gtkrc-2.0" #&&
rm -rf "$HOME/.zshrc" #&&
rm -rf "$HOME/.icons" #&&
rm -rf "$HOME/.themes" #&&
rm -rf "$HOME/.tmux.conf" #&&
rm -rf "$HOME/.tmux" #&&
rm -rf "$HOME/tpm" #&&
rm -rf "$HOME/.vimrc" #&&
rm -rf "$HOME/.wezterm.lua" #&&
rm -rf "$HOME/.gitconfig" #&&
rm -rf "$HOME/wallpaper" #&&
rm -rf "$HOME/.Xresources" #&&

ln -s "$HOME/dotfiles/.bashrc" "$HOME/.bashrc"
ln -s "$HOME/dotfiles/.zshrc" "$HOME/.zshrc"
ln -s "$HOME/dotfiles/.icons" "$HOME/.icons"
ln -s "$HOME/dotfiles/.themes" "$HOME/.themes"
ln -s "$HOME/dotfiles/.tmux.conf" "$HOME/.tmux.conf"
ln -s "$HOME/dotfiles/.tmux" "$HOME/.tmux"
ln -s "$HOME/dotfiles/tpm" "$HOME/tpm"
ln -s "$HOME/dotfiles/.vimrc" "$HOME/.vimrc"
ln -s "$HOME/dotfiles/.wezterm.lua" "$HOME/.wezterm.lua"
ln -s "$HOME/dotfiles/.gitconfig" "$HOME/.gitconfig"
ln -s "$HOME/dotfiles/wallpaper" "$HOME/wallpaper"
ln -s "$HOME/dotfiles/.Xresources" "$HOME/.Xresources"
ln -s "$HOME/dotfiles/.gtkrc-2.0" "$HOME/.gtkrc-2.0"

for i in $(/bin/ls -a "$HOME"/dotfiles/config | tail -n +3); do
    if [ -d "$HOME/.config/${i}" ]; then
    	rm -rf "${HOME}/.config/$i"
    fi
    ln -s "${HOME}/dotfiles/config/${i}" "$HOME/.config/$i"
done

sudo cp "$HOME"/.config/rofi/colors/tokyonight.rasi /usr/share/rofi/themes/
sudo cp "$HOME"/.config/rofi/colors/catppuccin.rasi /usr/share/rofi/themes/
sudo cp "$HOME"/.config/rofi/colors/cyberpunk.rasi /usr/share/rofi/themes/

 sudo pacman -Syu --noconfirm && yay -Syu --noconfirm

 "$HOME"/dotfiles/rofiFonts/setup.sh

if [[ "$(echo "$SHELL" | grep zsh)" ]]; then
    source "$HOME"/.zshrc
else
    chsh -s /bin/zsh
    echo "Please close and reopen the terminal. Or logout and log back int to the session for the SHELL change to take affect!"
fi

sudo -k
