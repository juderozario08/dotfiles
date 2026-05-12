#!/usr/bin/env bash

Color_Off='\033[0m'
BYellow='\033[1;33m'
BBlue='\033[1;34m'

DIR="$HOME/dotfiles/rofiFonts"
FONT_DIR="$HOME/.local/share/fonts"

install_fonts() {
	echo -e "${BBlue}\n[*] Installing fonts...${Color_Off}"
	if [[ -d "$FONT_DIR" ]]; then
		cp -rf "$DIR"/fonts/* "$FONT_DIR"
	else
		mkdir -p "$FONT_DIR"
		cp -rf "$DIR"/fonts/* "$FONT_DIR"
	fi
	echo -e "${BYellow}[*] Updating font cache...\n${Color_Off}"
	fc-cache
}

install_fonts
