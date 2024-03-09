 # Path to dotfiles
 export DOTFILES=$HOME/.dotfiles
 export OBSIDIAN="${HOME}/Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/obsidian"

 # PATH definition
 export PATH=/opt/homebrew/bin:$PATH
 export PATH=$PATH:~/.composer/vendor/bin
 export PATH="./vendor/bin:$PATH"
 export PATH="$HOME/.cargo/bin:$PATH"
 export PATH="$HOME/.local/bin:$PATH"

 # Path to your oh-my-zsh installation.
 export ZSH=$HOME/.oh-my-zsh

 # Set date format
 HIST_STAMPS="dd.mm.yyyy"

 # Plugins definition
 plugins=(git laravel zsh-syntax-highlighting zsh-autosuggestions node artisan zsh-completions)

 source $ZSH/oh-my-zsh.sh

 # Welcome screen
 nerdfetch

 # Set language environment
 export LANG=en_US.UTF-8
 export LC_ALL=en_US.UTF-8

 # Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='nvim'
 else
   export EDITOR='nvim'
 fi

 export TERM=xterm

 # Source aliases
 source $DOTFILES/aliases.zsh
 source $DOTFILES/aliases-docker.zsh
 
 # Source commands
 source $DOTFILES/commands.zsh

 # OpenAI
 source ~/.config/.openai

 # Python
 module_init
 if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
 fi

 # Ripgrep
 RIPGREP_CONFIG_PATH="~/.config/.ripgreprc"

 eval "$(starship init zsh)"

 [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

