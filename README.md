## Dotfiles

### Description
This repository contains my personal configurations for various tools and applications that I use on a daily basis.
My daily driver is a Linux machine running Arch Linux with i3 as the window manager.
The `install.sh` script will create symlinks to the configurations in the appropriate directories and also install all dependencies as needed.
<br><br>

NOTE: This will overwrite any existing configurations in your home directory.
Also if ZSH is not your default shell, the script will change it to ZSH but you will have to run the script again to finish the rest of the process.
To get my configurations, run the following command:

```sh
git clone https://github.com/juderozario08/dotfiles.git && cd dotfiles && ./install.sh
```

### Caelestia shell health check
Caelestia relies on AUR packages (`libcava`, `quickshell-git`, `caelestia-shell`, `qt6-m3shapes-git`) that break when an
official repo library they link against changes (e.g. a `sndio` soname bump or a Qt update).
`arch_install.sh` installs `system/bin/caelestia-doctor` to `/usr/local/bin` and a pacman hook to `/etc/pacman.d/hooks/`:

- After every pacman/yay/paru transaction the hook prints a red warning if Caelestia is broken.
- At Hyprland login, `caelestia-doctor --startup` sends a notification if something is broken, then starts the shell.
- `caelestia-doctor --fix` rebuilds exactly the broken packages and restarts the shell.

If you edit `system/bin/caelestia-doctor`, reinstall it with
`sudo install -Dm755 system/bin/caelestia-doctor /usr/local/bin/caelestia-doctor`.
