#!/bin/bash

# Fresh macOS setup. Safe to run more than once.
# Usage: ~/.dotfiles/fresh.sh

set -e

DOTFILES="$HOME/.dotfiles"

echo "Setting up your Mac... 💻"

# Xcode Command Line Tools
if ! xcode-select -p &>/dev/null; then
  xcode-select --install
  echo "Finish installing the Command Line Tools, then run this script again."
  exit 1
fi

# Rosetta (some casks still need it)
if [[ "$(uname -m)" == "arm64" ]] && ! /usr/bin/pgrep -q oahd; then
  sudo softwareupdate --install-rosetta --agree-to-license
fi

# Homebrew
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"
grep -q 'brew shellenv' "$HOME/.zprofile" 2>/dev/null || echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"

# Install everything from the Brewfile.
# Mac App Store apps need you to be signed in to the App Store first.
brew update
brew bundle --file="$DOTFILES/Brewfile" || echo "⚠️  Some Brewfile entries failed, check the output above."

# Oh My Zsh and custom plugins
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
clone_plugin() {
  [ -d "$ZSH_CUSTOM/plugins/$1" ] || git clone --depth 1 "$2" "$ZSH_CUSTOM/plugins/$1"
}
clone_plugin artisan https://github.com/jessarcher/zsh-artisan.git
clone_plugin zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions
clone_plugin zsh-completions https://github.com/zsh-users/zsh-completions
clone_plugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git

# Symlinks
# link <source in dotfiles> <target>
link() {
  local src="$DOTFILES/$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mv "$dst" "$dst.backup.$(date +%s)"
  fi
  ln -sfn "$src" "$dst"
}

link .zshrc "$HOME/.zshrc"
link .gitignore_global "$HOME/.gitignore_global"
link .mackup.cfg "$HOME/.mackup.cfg"
link .shellcheckrc "$HOME/.shellcheckrc"
link git-templates "$HOME/.git-templates"
link .config/.claude "$HOME/.claude"
link .config/.pi "$HOME/.pi"
link .config/.agents "$HOME/.agents"
link pint.json "$HOME/.config/pint.json"
link .config/.ripgreprc "$HOME/.config/.ripgreprc"
link .config/startship/starship.toml "$HOME/.config/starship.toml"
for dir in aerospace bat btop ghostty lazygit nvim opencode phpactor swiftbar vectorcode zellij; do
  link ".config/$dir" "$HOME/.config/$dir"
done

# Git
git config --global core.excludesfile "$HOME/.gitignore_global"
git config --global init.templatedir "$HOME/.git-templates"
git config --global init.defaultBranch main

# Rust
if ! command -v cargo &>/dev/null && [ ! -x "$HOME/.cargo/bin/cargo" ]; then
  rustup-init -y --no-modify-path
fi
grep -q '.cargo/env' "$HOME/.zshenv" 2>/dev/null || echo '. "$HOME/.cargo/env"' >> "$HOME/.zshenv"

# Python
pyenv install --skip-existing 3.13
pyenv global "$(pyenv latest 3.13)"

# PHP & Laravel
mkdir -p "$HOME/Developer/php/projects" "$HOME/Developer/php/packages"
composer global require laravel/installer laravel/valet beyondcode/expose
"$HOME/.composer/vendor/bin/valet" install

# Neovim: install plugins at the versions pinned in lazy-lock.json.
# Mason tools and treesitter parsers install on the first interactive start.
nvim --headless "+Lazy! restore" +qa

# macOS preferences. Runs last because it restarts Finder and the Dock.
source "$DOTFILES/.macos"
