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
        i3-wm hyprland obsidian obs-studio sddm-sugar-dark systemd gnome-tweaks usleep vesktop \
        lxappearance spotify bash-pipes blueman polybar rofi maim xclip ttf-firacode-nerd lua luarocks \
        hyprpaper hyprlock hypridle hyprshot grim swaync wezterm hyprcursor xdg-desktop-portal-hyprland \
        qt6-svg qt6-virtualkeyboard qt6-multimedia-ffmpeg gum eog --noconfirm

    # Caelestia shell stack (Hyprland bar/launcher) + what hypr/conf/autostart.lua launches
    yay -S --needed --noconfirm caelestia-shell caelestia-cli quickshell-git libcava qt6-m3shapes-git \
        libnotify mpvpaper cliphist wl-clipboard network-manager-applet \
        qtengine darkly papirus-icon-theme

    # Apps & dev tools
    yay -S --needed --noconfirm claude-code visual-studio-code-bin zed neovim vim nano google-chrome brave-nightly-bin \
        discord lmstudio-bin localsend-bin antigravity-cli anydesk-legacy-bin virtualbox-bin yazi htop mise \
        sdkman-bin appimagelauncher raddebugger qml-lsp-git cava wget openssh lldb

    # Java / Android
    yay -S --needed --noconfirm jdk21-openjdk openjdk21-doc jdk25-openjdk openjdk25-doc gradle \
        android-sdk android-sdk-cmdline-tools-latest android-emulator

    # System & hardware utilities, fonts
    yay -S --needed --noconfirm bluez bluez-utils cups cups-pk-helper system-config-printer \
        noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-dejavu ttf-liberation zram-generator \
        amdgpu_top rocm-smi-lib fancontrol-gui smartmontools hyprlauncher hyprsysteminfo uwsm \
        networkmanager pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber gst-plugin-pipewire \
        xdg-utils xdg-user-dirs-gtk

    # GNOME desktop (available as a fallback session; SDDM stays the login manager, gdm is not enabled)
    yay -S --needed --noconfirm gnome-shell gnome-session gnome-settings-daemon gnome-control-center gdm \
        gnome-backgrounds gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-color-manager \
        gnome-connections gnome-console gnome-contacts gnome-disk-utility gnome-font-viewer gnome-keyring \
        gnome-logs gnome-maps gnome-menus gnome-music gnome-remote-desktop gnome-software gnome-system-monitor \
        gnome-text-editor gnome-tour gnome-user-docs gnome-user-share gnome-weather xdg-desktop-portal-gnome \
        gvfs gvfs-afc gvfs-dnssd gvfs-goa gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-onedrive gvfs-smb gvfs-wsdd \
        baobab decibels epiphany grilo-plugins gst-thumbnailers loupe malcontent orca papers rygel showtime \
        simple-scan snapshot sushi tecla yelp

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
    remove_path_if_exists "$HOME/.clang-format"
    remove_path_if_exists "$HOME/.fehbg"
    remove_path_if_exists "$HOME/.clangd"
    remove_path_if_exists "$HOME/tpm"
    remove_path_if_exists "$HOME/.gtkrc-2.0"
    remove_path_if_exists "$HOME/.p10k.zsh"
    remove_path_if_exists "$HOME/.zshenv"
    remove_path_if_exists "$HOME/.bash_profile"

    link_path "$HOME/dotfiles/.p10k.zsh" "$HOME/.p10k.zsh"
    link_path "$HOME/dotfiles/.zshenv" "$HOME/.zshenv"
    link_path "$HOME/dotfiles/.bash_profile" "$HOME/.bash_profile"
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
    link_path "$HOME/dotfiles/.clang-format" "$HOME"/.clang-format
    link_path "$HOME/dotfiles/.fehbg" "$HOME"/.fehbg
    link_path "$HOME/dotfiles/.clangd" "$HOME/.clangd"

    for i in $(/bin/ls -a "$HOME"/dotfiles/config | tail -n +3); do
        remove_path_if_exists "$HOME/.config/${i}"
        link_path "${HOME}/dotfiles/config/${i}" "$HOME/.config/$i"
    done
}

# pacman.conf: colored output, verbose package lists, parallel downloads, multilib repo.
# Runs before any package install so multilib packages resolve.
setup_pacman_conf() {
    sudo sed -i -E \
        -e 's/^#\s*Color$/Color/' \
        -e 's/^#\s*VerbosePkgLists$/VerbosePkgLists/' \
        -e 's/^#?\s*ParallelDownloads\s*=.*/ParallelDownloads = 5/' \
        /etc/pacman.conf
    # Uncomment the [multilib] section header and its Include line
    sudo sed -i -E '/^#\s*\[multilib\]$/{s/^#\s*//;n;s/^#\s*//}' /etc/pacman.conf
    sudo pacman -Sy
}

# Services, zram swap, and user groups
setup_system() {
    sudo install -Dm644 "$HOME/dotfiles/system/etc/zram-generator.conf" /etc/systemd/zram-generator.conf

    sudo systemctl enable sddm.service NetworkManager.service bluetooth.service \
        sshd.service cups.service lm_sensors.service

    # VirtualBox USB passthrough needs vboxusers
    getent group vboxusers >/dev/null && sudo usermod -aG vboxusers "$USER"
    systemctl --user enable xdg-user-dirs.service || true
}

# caelestia-doctor: detects AUR packages broken by repo upgrades (soname bumps, Qt bumps)
# and rebuilds them. The pacman hook warns after every transaction; Hyprland autostart
# notifies at login. Copied (not symlinked) because the hook runs it as root.
setup_caelestia_doctor() {
    sudo install -Dm755 "$HOME/dotfiles/system/bin/caelestia-doctor" /usr/local/bin/caelestia-doctor
    sudo install -Dm644 "$HOME/dotfiles/system/pacman-hooks/zz-caelestia-doctor.hook" \
        /etc/pacman.d/hooks/zz-caelestia-doctor.hook
}

setup_rofi() {
    sudo cp "$HOME"/.config/rofi/colors/tokyonight.rasi /usr/share/rofi/themes/
    sudo cp "$HOME"/.config/rofi/colors/catppuccin.rasi /usr/share/rofi/themes/
    sudo cp "$HOME"/.config/rofi/colors/cyberpunk.rasi /usr/share/rofi/themes/
    "$HOME"/dotfiles/rofiFonts/setup.sh
}

gain_sudo
setup_pacman_conf
install_rust
install_yay
install_dependencies
link_dots
setup_sddm
setup_system
setup_caelestia_doctor

sudo pacman -Syu --noconfirm && yay -Syu --noconfirm

# Rebuild any Caelestia AUR packages the upgrade above may have broken
caelestia-doctor --fix || echo "caelestia-doctor --fix failed; rerun it manually." >&2

if [[ "$(echo "$SHELL" | grep zsh)" ]]; then
    source "$HOME"/.zshrc
else
    chsh -s /bin/zsh
    echo "Please close and reopen the terminal. Or logout and log back int to the session for the SHELL change to take affect!"
fi

sudo -k
