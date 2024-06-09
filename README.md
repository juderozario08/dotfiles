# Dependencies

Also install <a href="https://git-scm.com/book/en/v2/Getting-Started-Installing-Git">Git</a> and <a href="https://curl.se/download.html">curl</a>

### Homebrew
<li>
    <a href="https://brew.sh/">Homebrew</a>
</li>

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Oh My Zsh
<li>
    <a href="https://brew.sh/">Oh My Zsh</a>
</li>

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Config contains p10k for terminal styling, and zinit package manager for terminal plugins. Alacritty is the main terminal. 
All config files can be found in config folder of this repo. Main theme is Catppuccin for the terminal and TokyoNight for neovim
<br><br>
## Using brew or the desired package manager, install the following:
<li>zoxide</li>
<li>eza</li>
<li>fd</li>
<li>fzf</li>
<li>vivid</li>

Using brew just write this

```sh
brew install zoxide eza fd fzf vivid
```
