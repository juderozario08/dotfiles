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
