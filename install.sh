#!/bin/bash

OS=$(uname)

git clone https://github.com/juderozario/dotfiles.git ~/

if [ "$OS" == "Linux" ]; then
    source ./arch_install.sh
else
    source ./mac_install.sh
fi
