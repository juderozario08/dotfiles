#!/bin/bash

# brew setup
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/.zshrc
source "$HOME"/.zshrc || exit

# cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
. "$HOME"/.cargo/env

#dependencies
sudo pacman -S --needed git base-devel
cd ~ || exit
git clone https://aur.archlinux.org/yay.git
cd yay || exit
makepkg -si

sudo pacman -S fd firefox ripgrep npm eza zoxide htop tokei tree bat fzf lazygit tmux btop pyenv vivid deno inetutils nwg-look --noconfirm
brew install fd ripgrep npm eza zoxide htop tokei tree bat fzf zsh gh tmux
cargo install alacritty vivid
yay -S gtk3 gtk4 hyprland nautilus pavucontrol pulse qt6ct rofi starship systemd waybar wlogout xsettingsd \
    sddm hyprpaper hyprlock hypridle hyprshot hyprutils swaync wezterm-git alacritty webcord obsidian obs-studio \
    zen-browser-bin sddm-sugar-dark mpvpaper betterlockscreen systemd --noconfirm

cd ~ || exit
git clone https://github.com/junegunn/fzf-git.sh

sudo pacman -Syu --noconfirm
yay -Syu --noconfirm

for i in $(ls -a ~/dotfiles/config/ || exit); do
    rm -rf "$HOME/.config/${i}" 2>/dev/null
    ln -s "$HOME/dotfiles/config/${i}" "$HOME/.config/$i"
done

rm -rf ~/.bashrc 2>/dev/null
ln -s "$HOME/dotfiles/.bashrc" "$HOME/.bashrc"
rm -rf ~/.zshrc 2>/dev/null
ln -s "$HOME/dotfiles/.zshrc" "$HOME/.zshrc"
rm -rf ~/.icons 2>/dev/null
ln -s "$HOME/dotfiles/.icons" "$HOME/.icons"
rm -rf ~/.themes 2>/dev/null
ln -s "$HOME/dotfiles/.themes" "$HOME/.themes"
rm -rf ~/.tmux.conf 2>/dev/null
ln -s "$HOME/dotfiles/.tmux.conf" "$HOME/.tmux.conf"
rm -rf ~/.tmux 2>/dev/null
ln -s "$HOME/dotfiles/.tmux" "$HOME/.tmux"
rm -rf ~/tpm 2>/dev/null
ln -s "$HOME/dotfiles/tpm" "$HOME/tpm"
rm -rf ~/.vimrc 2>/dev/null
ln -s "$HOME/dotfiles/.vimrc" "$HOME/.vimrc"
rm -rf ~/.wezterm.lua 2>/dev/null
ln -s "$HOME/dotfiles/.wezterm.lua" "$HOME/.wezterm.lua"
rm -rf ~/.gitconfig 2>/dev/null
ln -s "$HOME/dotfiles/.gitconfig" "$HOME/.gitconfig"
rm -rf ~/wallpaper 2>/dev/null
ln -s "$HOME/dotfiles/wallpaper" "$HOME/wallpaper"
rm -rf ~/.Xresources 2>/dev/null
ln -s "$HOME/dotfiles/.Xresources" "$HOME/.Xresources"
rm -rf ~/.gtkrc-2.0 2>/dev/null
ln -s "$HOME/dotfiles/.gtkrc-2.0" "$HOME/.gtkrc-2.0"

sudo cp "$HOME"/.config/rofi/colors/tokyonight.rasi /usr/share/rofi/themes/
sudo cp "$HOME"/.config/rofi/colors/catppuccin.rasi /usr/share/rofi/themes/
sudo cp "$HOME"/.config/rofi/colors/cyberpunk.rasi /usr/share/rofi/themes/

yay -S ttf-fira-code ttf-firacode-nerd ttf-cascadia-code-nerd ttf-cascadia-mono-nerd ttf-jetbrains-mono-nerd

chmod u+x rofiFonts/setup.sh
./rofiFonts/setup.sh

curl -fsSL https://bun.sh/install | bash

source "$HOME"/.zshrc
