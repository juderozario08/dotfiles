[[ -n "$ZSH_VERSION" ]] || return
export ZSH="$HOME/.oh-my-zsh"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export EDITOR="nvim"
if [[ $(uname) != "Darwin" ]]; then
    if [ -d "/home/linuxbrew" ]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        export HOMEBREW_PATH="/home/linuxbrew/.linuxbrew"
        export PATH="${HOMEBREW_PATH}/bin:${PATH}"
    fi
    export PATH="$PATH:/home/juderozario/.spicetify"
    export EDITOR='/bin/nvim'
    export SDL_VIDEODRIVER=wayland
else
    export HOMEBREW_PATH="/opt/homebrew"
    export PATH="$HOMEBREW_PATH/opt/ruby/bin:$HOMEBREW_PATH/opt/man-db/libexec/bin:$PATH"
    export EDITOR="$HOMEBREW_PATH/bin/nvim"
fi

alias v="$EDITOR"
alias zshconfig="$EDITOR ~/.zshrc"
alias va="$EDITOR ~/.config/alacritty/alacritty.toml"
alias vk="$EDITOR ~/.config/kitty/kitty.conf"
alias vw="$EDITOR ~/.wezterm.lua"
alias vh="$EDITOR ~/.config/hypr/hyprland.conf"
alias so="source ~/.zshrc"
alias l='eza --color=always --icons=always --long --all'
alias ls='eza --color=always --icons=always'
alias cd='z'
alias tree='eza --tree --icons --ignore-glob=node_modules'
alias cat='bat'
alias t='tmux'
alias td='tmux detach'
alias tns='tmux new-session -s'
alias ta='tmux attach-session -t'
alias tls='tmux list-sessions'
alias tka='tmux kill-session -a'
alias tkt='tmux kill-session -t'
alias uni="ssh jarozari@moon.cs.torontomu.ca"

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


fzf-neovim() {
    local dir
    dir=$(fd -Ht d --exclude .git --exclude node_modules | fzf)
    if [ -n "$dir" ]; then
        cd "$dir"
        nvim
    fi
}

autoload -Uz edit-command-line
autoload zmv
zle -N edit-command-line
zle -N fzf-neovim
bindkey '^[n' fzf-neovim
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey "\\e[1;3C" forward-word
bindkey "\\e[1;3D" backward-word
bindkey '^x^e' edit-command-line

export MANPAGER="nvim +Man!"

alias -s md="bat"
alias -s go="$EDITOR"
alias -s c="$EDITOR"
alias -s cpp="$EDITOR"
alias -s rs="$EDITOR"
alias -s js="$EDITOR"
alias -s ts="$EDITOR"
alias -s json="jless"

alias -g NE='2>/dev/null'
alias -g ND='>/dev/null'
alias -g NUL='>/dev/null 2>1'
alias -g JQ='| jq'
alias -g C='| wl-copy'
export PATH="$(brew --prefix python@3.13)/libexec/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
