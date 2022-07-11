#!/bin/sh

echo "Setting up your Mac... 💻"

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Set default MySQL root password and auth type.
# mysql -u root -e "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY 'password'; FLUSH PRIVILEGES;"

# Install PHP extensions with PECL
sudo pecl install imagick

# Install global Composer packages
/usr/local/bin/composer global require laravel/installer laravel/valet

# Install Laravel Valet
$HOME/.composer/vendor/bin/valet install

# Create a Sites directory
# This is a default directory for macOS user accounts but doesn't comes pre-installed
mkdir $HOME/Developer

# Create sites subdirectories
mkdir $HOME/Developer/php

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Symlink neovim config files
ln -s $HOME/.dotfiles/.config/nvim $HOME/.config/nvim

# Symlink lazygit config file
ln -s $HOME/.dotfiles/lazygit.yml '/Users/theimer/Library/Application Support/jesseduffield/lazygit/config.yml'

# Symlink the Mackup config file to the home directory
rn -rf $HOME/.mackup.cfg
ln -s $HOME/.dotfiles/.mackup.cfg $HOME/.mackup.cfg

# Symlink global gitignore file
rm -rf $HOME/.gitignore_global
ln -s $HOME/.dotfiles/.gitignore_global $HOME/.gitignore_global

# Set global giignore
git config --global core.excludesfile ~/.gitignore_global

# Set macOS preferences
# We will run this last because this will reload the shell
source .macos
