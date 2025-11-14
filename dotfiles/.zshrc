# ═══════════════════════════════════════════════════════════════════
# ZSH CONFIGURATION
# ═══════════════════════════════════════════════════════════════════

# ───────────────────────────────────────────────────────────────────
# OH-MY-ZSH SETTINGS
# ───────────────────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"

# Plugins
plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# ───────────────────────────────────────────────────────────────────
# TERMINAL & EDITOR
# ───────────────────────────────────────────────────────────────────
export TERM=xterm-256color
export EDITOR="nvim"

# ───────────────────────────────────────────────────────────────────
# PATH CONFIGURATION
# ───────────────────────────────────────────────────────────────────
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

# ───────────────────────────────────────────────────────────────────
# PROMPT & THEME
# ───────────────────────────────────────────────────────────────────
export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"

# ───────────────────────────────────────────────────────────────────
# MODERN CLI TOOLS
# ───────────────────────────────────────────────────────────────────

# Zoxide (better cd)
eval "$(zoxide init zsh --cmd cd)"

# Bat - use Dracula theme
export BAT_THEME="Dracula"

# FZF - Dracula theme
export FZF_DEFAULT_OPTS="--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

# Eza colors
export EZA_COLORS="da=1;34:gm=1;34"

# Delta (git diff)
export DELTA_FEATURES="+side-by-side"

# Atuin
if [ -f "$HOME/.atuin/bin/env" ]; then
    . "$HOME/.atuin/bin/env"
fi

export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"
bindkey '^r' _atuin_search_widget

# ───────────────────────────────────────────────────────────────────
# ALIASES - FILE OPERATIONS
# ───────────────────────────────────────────────────────────────────

# Navigation
alias home='cd ~'
alias ..='cd ..'
alias ...='cd ../..'

# File listing (eza)
alias ls='eza --icons --group-directories-first'
alias ll='eza --icons --group-directories-first -l'
alias la='eza --icons --group-directories-first -la'
alias lt='eza --icons --group-directories-first --tree'
alias l='eza --icons --group-directories-first -F'

# File viewing
alias cat='bat --style=plain --paging=never'
alias catp='bat --style=full'

# Better replacements
alias du='dust'
alias df='duf'
alias ps='procs'
alias top='btop'

# ───────────────────────────────────────────────────────────────────
# ALIASES - GIT
# ───────────────────────────────────────────────────────────────────
alias lg='lazygit'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'

# ───────────────────────────────────────────────────────────────────
# ALIASES - UTILITIES
# ───────────────────────────────────────────────────────────────────

# Configuration
alias zsource='source ~/.zshrc'
alias zconfig='nvim ~/.zshrc'
alias nconfig='nvim ~/.config/nvim'
alias sconfig='nvim ~/.config/starship.toml'

# Zellij
alias zj='zellij options --theme dracula'
alias zellij-clean='zellij list-sessions --no-formatting | cut -d" " -f1 | xargs -I {} zellij delete-session {} --force'

# Quick commands
alias h='history'
alias help='tldr'
alias ports='netstat -tulanp'

# ───────────────────────────────────────────────────────────────────
# FUNCTIONS
# ───────────────────────────────────────────────────────────────────

# Quick directory navigation
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract any archive
extract() {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# ───────────────────────────────────────────────────────────────────
# COMPLETIONS
# ───────────────────────────────────────────────────────────────────
fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit
compinit


# Exegol alias
alias exegol='sudo -E /home/p3ta/.local/bin/exegol'
xhost +si:localuser:root >/dev/null 2>&1
