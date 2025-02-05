# config.nu
#
# Installed by:
# version = "0.102.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

# Aliases

## Shortcuts
alias copyssh = pbcopy < ($env.HOME | path join '/.ssh/id_rsa.pub')
alias reloaddns = dscacheutil -flushcache and sudo killall -HUP mDNSResponder
alias shrug = echo '¯\_(ツ)_/¯' | pbcopy
alias c = clear
alias .. = cd ..

## Directories
alias dot = cd $env.DOTFILES
# alias conf = cd ($env.DOTFILES | path join '/.config')
alias obs = cd $env.OBSIDIAN
alias repos = cd ~/Developer
alias ppd = cd ~/Developer/php
alias pro = cd ~/Developer/php/projects
alias pac = cd ~/Developer/php/packages

## Git
alias gc = git commit -m
alias gca = git commit -a -m
alias gr = git reset
alias grs = git reset --soft HEAD~1
alias gst = git status
alias gb = git branch
alias gco = git checkout
alias glog = git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit
alias gba = git branch -a
alias gadd = git add
alias ga = git add -p
alias gcoall = git checkout -- .

## Files
alias lll = ll -l
alias ll = ls --all
alias lt = eza --tree --level=2 --long --icons --git

## Vim
alias v = nvim
alias vim = nvim

## Aerospace
def ff [] {
    aerospace list-windows --all | fzf --bind 'enter:execute(bash -c "aerospace focus --window-id {1}")+abort'
}

source ~/.config/nushell/env.nu
source ~/.zoxide.nu
use ~/.cache/starship/init.nu
