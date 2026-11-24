#!/bin/bash

OS=$(uname)

if [ ! -d "$HOME/dotfiles/.git" ]; then
    git clone --recurse-submodules https://github.com/juderozario08/dotfiles.git "$HOME/dotfiles"
fi
cd "$HOME/dotfiles" || exit 1

if [ "$OS" == "Linux" ]; then
    source ./arch_install.sh
else
    source ./mac_install.sh
fi
