# Aliases

## Shortcuts
alias copyssh="pbcopy < $HOME/.ssh/id_rsa.pub"
alias reloadshell="source $HOME/.zshrc"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias c="clear"

# Directories
alias dotfiles="cd $DOTFILES"                           # Go to .dotfiles directory
alias repos="cd ~/Developer"                            # Open default projects directory
alias lara="cd ~/Developer/php"                         # Open default php / laravel projects directory

## PHP & Laravel aliases
alias a="php artisan"                                   # Run artisan
alias pamfds="php artisan migrate:fresh --seed"         # Migrate fresh database and seed it
alias pam="php artisan migrate"                         # Migrate database
alias pas="php artisan seed"                            # Seed database
alias cdao="composer dump-autoload -o"                  # Composer dump autoload optimised
alias cr="composer require"                             # Composer require
alias ci="composer install"                             # Composer install
alias cu="composer update"                              # Composer update
alias t="./vendor/bin/pest"                             # Run Pest tests
alias pt="./vendor/bin/phpunit"                             # Run PHPUnit tests

## JavaScript aliases
alias yn="yarn nuxt"                                    # Run nuxt
alias yrp="yarn run production"                         # Run production
alias yrp="yarn run watch"                              # Run watch
alias y="yarn"                                          # Run yarn

## Git
alias grs="git reset --soft HEAD~1"                     # Git reset soft
alias gst="git status"                                  # Git status
alias gb="git branch"                                   # Git branch
alias gc="git checkout"                                 # Git checkout
alias gl="git log --oneline --decorate --color"         # Git log
alias amend="git add . && git commit --amend --no-edit" # Git ament
alias commit="git add . && git commit -m"               # Git commit
alias diff="git diff"                                   # Git diff
alias pull="git pull"                                   # Git pull
alias push="git push"                                   # Git push
alias unstage="git restore --staged ."                  # Git unstage
alias wip="commit wip"                                  # Git commit wip

## Python
# alias pip="pip3"                                      # Use pip3
# alias python="python3"                                # Use python3

## Files
alias ll="ls -lGaf"                                     # Better file listing

## Vim
alias vim="nvim"                                        # Use nvim
alias neo="neovide --multigrid"                         # Use neovide
alias vimr="vimr"                                       # Use vimr

## ZSH
alias zshconfig="vim ~/.zshrc"                          # Open zsh config in vim
alias ohmyzsh="vim ~/.oh-my-zsh"                        # Open oh my zsh config in vim
