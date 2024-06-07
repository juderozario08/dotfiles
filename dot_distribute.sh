# dotifles symlink for all .dotconfig files 
rm -rf ~/.config/alacritty
./symlink.sh ~/dotfiles/config/alacritty ~/.config/alacritty
rm -rf ~/.config/nvim
./symlink.sh ~/dotfiles/config/nvim ~/.config/nvim
rm -rf ~/.config/kitty
./symlink.sh ~/dotfiles/config/kitty ~/.config/kitty
rm -rf ~/.config/picom
./symlink.sh ~/dotfiles/config/picom ~/.config/picom
rm -rf ~/.config/polybar
./symlink.sh ~/dotfiles/config/polybar ~/.config/polybar
rm -rf ~/.config/rofi
./symlink.sh ~/dotfiles/config/rofi ~/.config/rofi
rm -rf ~/.config/screenlayout
./symlink.sh ~/dotfiles/config/screenlayout ~/.config/screenlayout
rm -rf ~/.config/xresources
./symlink.sh ~/dotfiles/config/xresources ~/.config/xresources
rm -rf ~/.config/i3
./symlink.sh ~/dotfiles/config/i3 ~/.config/i3
rm -rf ~/.config/bat
./symlink.sh ~/dotfiles/config/bat ~/.config/bat
rm -rf ~/.config/backgrounds
./symlink.sh ~/dotfiles/config/backgrounds ~/.config/backgrounds

# fzf
rm -rf ~/fzf-git.sh
./symlink.sh ~/dotfiles/fzf/fzf-git.sh ~/fzf-git.sh

# zshrc
rm -rf ~/.zshrc
./symlink.sh ~/dotfiles/zshrc/.zshrc ~/

# tmux
rm -rf ~/.tmux.conf
./symlink.sh ~/dotfiles/tmux/.tmux.conf ~/
rm -rf ~/.tmux
./symlink.sh ~/dotfiles/tmux/.tmux ~/
rm -rf ~/tpm
./symlink.sh ~/dotfiles/tmux/tpm ~/

