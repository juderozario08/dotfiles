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

if ! command -v paru >/dev/null 2>&1; then
    cd "$HOME"
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
    cd ..
    rm -rf paru
fi

if ! command -v yay >/dev/null 2>&1; then
    cd "$HOME"
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay
fi

paru -Syu --needed git base-devel fd ripgrep npm eza zoxide htop tokei bat fzf zsh tmux deno alacritty wezterm firefox \
    pyenv vivid inetutils nwg-look man-db man-pages gtk3 gtk4 picom nautilus pavucontrol sddm \
    i3-wm hyprland obsidian obs-studio sddm-sugar-dark mpvpaper betterlockscreen systemd gnome-tweaks \
    lxappearance spicetify-cli dunst bash-pipes blueman polybar rofi maim xclip ttf-firacode-nerd --noconfirm

if [ ! -d "$HOME/fzf-git.sh" ]; then
    cd ~
    git clone https://github.com/junegunn/fzf-git.sh
    cd ~/dotfiles
fi

rm -rf "$HOME/.bashrc" && ln -sf "$HOME/dotfiles/.bashrc" "$HOME/.bashrc"
rm -rf "$HOME/.zshrc" && ln -sf "$HOME/dotfiles/.zshrc" "$HOME/.zshrc"
rm -rf "$HOME/.icons" && ln -sf "$HOME/dotfiles/.icons" "$HOME/.icons"
rm -rf "$HOME/.themes" && ln -sf "$HOME/dotfiles/.themes" "$HOME/.themes"
rm -rf "$HOME/.tmux.conf" && ln -sf "$HOME/dotfiles/.tmux.conf" "$HOME/.tmux.conf"
rm -rf "$HOME/.tmux" && ln -sf "$HOME/dotfiles/.tmux" "$HOME/.tmux"
rm -rf "$HOME/tpm" && ln -sf "$HOME/dotfiles/tpm" "$HOME/tpm"
rm -rf "$HOME/.vimrc" && ln -sf "$HOME/dotfiles/.vimrc" "$HOME/.vimrc"
rm -rf "$HOME/.wezterm.lua" && ln -sf "$HOME/dotfiles/.wezterm.lua" "$HOME/.wezterm.lua"
rm -rf "$HOME/.gitconfig" && ln -sf "$HOME/dotfiles/.gitconfig" "$HOME/.gitconfig"
rm -rf "$HOME/wallpaper" && ln -sf "$HOME/dotfiles/wallpaper" "$HOME/wallpaper"
rm -rf "$HOME/.Xresources" && ln -sf "$HOME/dotfiles/.Xresources" "$HOME/.Xresources"
rm -rf "$HOME/.gtkrc-2.0" && ln -sf "$HOME/dotfiles/.gtkrc-2.0" "$HOME/.gtkrc-2.0"

for i in $(/bin/ls -a ~/dotfiles/config | tail -n +3); do
    ln -sf "$HOME/dotfiles/config/${i}" "$HOME/.config/$i"
done

sudo cp "$HOME"/.config/rofi/colors/tokyonight.rasi /usr/share/rofi/themes/
sudo cp "$HOME"/.config/rofi/colors/catppuccin.rasi /usr/share/rofi/themes/
sudo cp "$HOME"/.config/rofi/colors/cyberpunk.rasi /usr/share/rofi/themes/

sudo pacman -Syu --noconfirm && paru -Syu --noconfirm

"$HOME"/dotfiles/rofiFonts/setup.sh

if [[ "$(echo "$SHELL" | grep zsh)" ]]; then
    source "$HOME"/.zshrc
else
    chsh -s /bin/zsh
    echo "Please close and reopen the terminal. Or logout and log back int to the session for the SHELL change to take affect!"
fi

sudo -k
