# Path to dotfiles
export DOTFILES=$HOME/.dotfiles
export OBSIDIAN="${HOME}/Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/obsidian"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $DOTFILES/.p10k.zsh ]] || source $DOTFILES/.p10k.zsh

# PATH definition
export PATH=/opt/homebrew/bin:$PATH
export PATH=$PATH:~/.composer/vendor/bin
export PATH="./vendor/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# ZSH theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set date format
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=$DOTFILES

# Plugins definition
plugins=(git laravel zsh-syntax-highlighting zsh-autosuggestions node artisan zsh-completions)

source $ZSH/oh-my-zsh.sh

# Set language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Example aliases

# Source aliases
source $DOTFILES/aliases.zsh

export TERM=xterm
# Source commands
source $DOTFILES/commands.zsh

# OpenAI
source ~/.config/.openai

module_init
if command -v pyenv 1>/dev/null 2>&1; then
 export PYENV_ROOT="$HOME/.pyenv"
 export PATH="$PYENV_ROOT/bin:$PATH"
 eval "$(pyenv init --path)"
 eval "$(pyenv init -)"
fi

RIPGREP_CONFIG_PATH="~/.config/.ripgreprc"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
