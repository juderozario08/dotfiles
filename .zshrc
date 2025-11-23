if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# ZINIT Installation
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -U compinit && compinit

alias so="source ~/.zshrc"
alias zshconfig="nvim ~/.zshrc"
alias l='eza --color=always --icons=always --long --all'
alias ls='eza --color=always --icons=always'
alias v='nvim'
alias cd='z'
alias va='nvim ~/.config/alacritty/alacritty.toml'
alias vk='nvim ~/.config/kitty/kitty.conf'
alias tree='eza --tree --icons --ignore-glob=node_modules'
alias cat='bat'
alias t='tmux'
alias td='tmux detach'
alias tns='tmux new-session -s'
alias ta='tmux attach-session -t'
alias tls='tmux list-sessions'
alias tka='tmux kill-session -a'
alias tkt='tmux kill-session -t'
alias vw='nvim ~/.wezterm.lua'
alias code='code-insiders'
alias uni="ssh jarozari@moon.cs.torontomu.ca"
alias lg='lazygit'
alias vh='nvim ~/.config/hypr/hyprland.conf'

bindkey -e
bindkey '^p' history-search-backward
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_verify
setopt hist_expire_dups_first

# Completion Styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf --preview 'eza --icons $realpath'

# Snippets
zinit snippet OMZP::git
zinit snippet OMZP::command-not-found

zinit cdreplay -q

eval "$(zoxide init zsh)"
export BAT_THEME="Catppuccin Mocha"
export DELTA_THEME="Catppuccin Mocha"
export LS_COLORS="$(vivid generate catppuccin-mocha)"

source <(fzf --zsh)
export FZF_DEFAULT_OPTS=" \
    --color=bg+:,bg:,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

source ~/fzf-git.sh/fzf-git.sh

# --- setup fzf theme ---
export FZF_DEFAULT_COMMAND="fd --hidden --type f --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
    fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
    fd --type=d --hidden --follow --exclude .git . "$1"
}

_fzf_comprun() {
    local command=$1
    shift
    case "$command" in
        cd) fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
        export|unset) fzf --preview "eval 'echo \$' {}" "$@" ;;
        ssh) fzf --preview "dig {}" "$@" ;;
        *)  fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
    esac
}

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}'"
export FZF_ALT_C_OPTS="--preview 'eza --color=always --tree --git-ignore --ignore-glob=node_modules {}'"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [ $(uname) != "Darwin"  ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    export PATH="/home/linuxbrew/.linuxbrew/opt/clang-format/bin:$PATH"
    export PATH="$PATH:/opt/nvim-linux64/bin:$HOME/go/bin"
    export PATH="/home/linuxbrew/.linuxbrew/opt/clang-format/bin:$PATH"
    export EDITOR='/home/linuxbrew/.linuxbrew/bin/nvim'
    alias open="xdg-open"
else
    alias man="~/man.sh"
fi

export PATH="/home/juderozario/.dotnet/tools:$PATH"

# bun completions
[ -s "/home/juderozario/.bun/_bun" ] && source "/home/juderozario/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

fzf-neovim() {
    local dir
    dir=$(fd -Ht d --exclude .git --exclude node_modules | fzf)
    if [ -n "$dir" ]; then
        cd "$dir"
        nvim
    fi
}
zle -N fzf-neovim
bindkey '^[n' fzf-neovim
PATH="/opt/homebrew/opt/man-db/libexec/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export MANPAGER="less"

export PATH=$PATH:/home/juderozario/.spicetify

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/juderozario/.dart-cli-completion/zsh-config.zsh ]] && . /home/juderozario/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]
#
## Commands for for docker
alias dcbuild='docker-compose build'
alias dcup='docker-compose up'
alias dcdown='docker-compose down'
alias dockps='docker ps --format "{{.ID}}  {{.Names}}"'
docksh() { docker exec -it $1 /bin/zsh; }

export SDL_VIDEODRIVER=wayland
