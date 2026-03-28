# 🌈 PRISM OS ZSH Configuration

# Oh My Zsh path
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"

# Plugins
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR=kitty
export PATH="$HOME/.local/bin:$PATH"

# Aliases
alias cls='clear && neofetch'
alias pic='pipes.sh -p 5 -t 0.1'
alias neo='neofetch'
alias top='htop'
alias fm='ranger'
alias update='sudo apt update && sudo apt upgrade -y'

# Neofetch on startup
neofetch
