# Default config path
export XDG_CONFIG_HOME="/Users/theimer/.config"

# Path to dotfiles
export DOTFILES=$HOME/.dotfiles
export OBSIDIAN="${HOME}/Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/obsidian"

# PATH definition
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="$PATH:$HOME/.composer/vendor/bin"
export PATH="./vendor/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"

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
plugins=(1password copypath fzf git zsh-autosuggestions zsh-completions zsh-syntax-highlighting)

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
export EDITOR='vim'
else
export EDITOR='nvim'
fi

# FZF
source <(fzf --zsh)

# Repl69 FZF Theme
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none \
  --color=bg+:#141414 \
  --color=bg:#0a0a0a \
  --color=border:#1f1f1f \
  --color=fg:#3d3d3d \
  --color=gutter:#101724 \
  --color=header:#292929 \
  --color=hl+:#7a7a7a \
  --color=hl:#c2c2c2 \
  --color=info:#adadad \
  --color=marker:#666666 \
  --color=pointer:#666666 \
  --color=prompt:#474747 \
  --color=query:#c2c2c2:regular \
  --color=scrollbar:#7a7a7a \
  --color=separator:#a3a3a3 \
  --color=spinner:#666666 \
"

# Source env secrets
op  inject --in-file "${DOTFILES}/secrets.zsh" | while read -r line; do
  eval "$line"
done

# Source aliases
source $DOTFILES/aliases.zsh
source $DOTFILES/aliases-docker.zsh

# Source commands
source $DOTFILES/commands.zsh

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Ripgrep
export RIPGREP_CONFIG_PATH="~/.config/.ripgreprc"

# Carapace
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

# Zoxide
eval "$(zoxide init zsh)"

# Starship
eval "$(starship init zsh)"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/theimer/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
