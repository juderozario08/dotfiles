# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# NEEDS RUST
. "$HOME/.cargo/env"

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Load completions
autoload -U compinit && compinit

# NEEDS eza, fd, tmux, nvim, bat, delta, fzf
alias so="source ~/.zshrc"
alias zshconfig="nvim ~/.zshrc"
alias l='eza --color=always --icons=always --git --long --all --git'
alias ls='eza --color=always --icons=always --git'
alias la='eza --all --color=always --icons=always --git'
alias v='nvim'
alias va='nvim ~/.config/alacritty/alacritty.toml'
alias tree='eza --all --tree --icons --git --ignore-glob=node_modules'
alias cat='bat'
alias td='tmux detach'
alias tns='tmux new-session -s'
alias ta='tmux attach-session -t'
alias tls='tmux list-sessions'
alias tka='tmux kill-session -a'
alias open='xdg-open'
alias tkt='tmux kill-session -t' 
alias cd='z'

eval "$(zoxide init zsh)"

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

# THE FUCK 
eval "$(thefuck --alias)"
eval "$(fzf --zsh)"


export PATH="/usr/bin/flutter/bin:$PATH"
# CATPPUCCIN FZF
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Snippets
zinit snippet OMZP::git
zinit snippet OMZP::command-not-found

zinit cdreplay -q

# SETTING UP BAT DELTA AND EZA THEMES
export BAT_THEME="Catppuccin Mocha"
export DELTA_THEME="Catppuccin Mocha"
export LS_COLORS="$(vivid generate catppuccin-mocha)"

# EXTRA FZF Functionality
source ~/fzf-git.sh/fzf-git.sh

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
 
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --color=always --tree --git-ignore --ignore-glob=node_modules {}'"
