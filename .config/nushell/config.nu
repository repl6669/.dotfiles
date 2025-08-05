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

# Env variables

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| "> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

# Directories
$env.DOTFILES = ($env.HOME | path join '.dotfiles')
$env.OBSIDIAN = ($env.HOME | path join 'Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/obsidian')

# Ripgrep
$env.RIPGREP_CONFIG_PATH = ($env.HOME | path join ".config/.ripgreprc")

# FZF
$env.FZF_DEFAULT_OPTS = '--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8'

# Config
$env.config = {
    show_banner: false

    rm: {
        always_trash: false # always act as if -t was given. Can be overridden with -p
    }

    edit_mode: vi

    # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (line is the default)
    cursor_shape: {
        emacs: block
        vi_insert: blink_block
        vi_normal: block
    }
}

# Aliases

## Shortcuts
alias copyssh = pbcopy < ($env.HOME | path join '/.ssh/id_rsa.pub')
alias reloaddns = dscacheutil -flushcache and sudo killall -HUP mDNSResponder
alias shrug = echo '¯\_(ツ)_/¯' | pbcopy
alias c = clear
alias .. = cd ..

## Directories
alias dot = cd $env.DOTFILES
alias conf = cd ($env.DOTFILES | path join '.config')
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

## Lazygit
alias lg = lazygit

## Aerospace
def ff [] {
    aerospace list-windows --all | fzf --bind 'enter:execute(bash -c "aerospace focus --window-id {1}")+abort'
}

source ~/.config/nushell/env.nu
source ~/.zoxide.nu
source ~/.cache/carapace/init.nu

use ~/.cache/starship/init.nu
source $"($nu.home-path)/.cargo/env.nu"
