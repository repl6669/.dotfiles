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

# Ollama settings
export OLLAMA_HOST="127.0.0.1"
export OLLAMA_CODE_MODEL="qwen2.5-coder:14b" # qwen3:14b

# Chroma settings
export CHROMA_CLIENT_TYPE="persistent"
export CHROMA_DATA_DIR="$HOME/.local/share/vectorcode"
export CHROMA_HOST="http://127.0.0.1"
export CHROMA_PORT="6131"
export CHROMA_CUSTOM_AUTH_CREDENTIALS=
export CHROMA_SSL="false"

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
  --color=bg+:#0a0a0a \
  --color=bg:#000000 \
  --color=border:#1f1f1f \
  --color=fg:#5c5c5c \
  --color=fg+:#999999 \
  --color=gutter:#0a0a0a \
  --color=header:#a3a3a3 \
  --color=hl+:#0df29e \
  --color=hl:#0bcb85 \
  --color=info:#adadad \
  --color=marker:#FF5C00 \
  --color=pointer:#FF5C00 \
  --color=prompt:#474747 \
  --color=query:#c2c2c2:regular \
  --color=scrollbar:#0bcb85 \
  --color=separator:#1f1f1f \
  --color=spinner:#FF5C00 \
"

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
