# Path to dotfiles
export DOTFILES=$HOME/.dotfiles
export OBSIDIAN="${HOME}/Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/obsidian"

# PATH definition
export PATH=/opt/homebrew/bin:$PATH
export PATH=$PATH:~/.composer/vendor/bin
export PATH="./vendor/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Neovide settings
export NEOVIDE_FRAME=transparent
export NEOVIDE_TITLE_HIDDEN=0
export NEOVIDE_TABS=0
export NEOVIDE_FORK=1

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set date format
HIST_STAMPS="dd.mm.yyyy"

# Plugins definition
plugins=(1password composer copypath fzf git zsh-autosuggestions zsh-completions zsh-syntax-highlighting)

# OMZ settings
zstyle ':omz:update' mode auto
source $ZSH/oh-my-zsh.sh

# Welcome screen
# nerdfetch

# Set language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
export EDITOR='nvim'
else
export EDITOR='nvim'
fi

if [[ $KITTY_WINDOW_ID ]]; then
export TERM=xterm-kitty
else
export TERM=xterm-256color
fi

# FZF
source <(fzf --zsh)

# Source aliases
source $DOTFILES/aliases.zsh
source $DOTFILES/aliases-docker.zsh

# Source commands
source $DOTFILES/commands.zsh

## Python
# module_init
# if command -v pyenv 1>/dev/null 2>&1; then
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init --path)"
# eval "$(pyenv init -)"
# fi

# Ripgrep
export RIPGREP_CONFIG_PATH="~/.config/.ripgreprc"

# Starship
eval "$(starship init zsh)"

