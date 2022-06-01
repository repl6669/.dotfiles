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
pecl install memcached imagick

# Install global Composer packages
/usr/local/bin/composer global require laravel/installer laravel/valet beyondcode/expose

# Install Laravel Valet
$HOME/.composer/vendor/bin/valet install

# Create a Sites directory
# This is a default directory for macOS user accounts but doesn't comes pre-installed
mkdir $HOME/Developer

# Create sites subdirectories
mkdir $HOME/Developer/laravel

# Clone Github repositories
./clone.sh

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Symlink neovim config files
ln -s $HOME/.dotfiles/.config/nvim $HOME/.config/nvim

# Symlink the Mackup config file to the home directory
rn -rf $HOME/.mackup.cfg
ln -s $HOME/.dotfiles/.mackup.cfg $HOME/.mackup.cfg

# Symlink python virtual env
ln -s $HOME/.dotfiles/.config/python-m1-env $HOME/.config/python-m1-env

# Symlink global gitignore file
rm -rf $HOME/.gitignore_global
ln -s $HOME/.dotfiles/.gitignore_global $HOME/.gitignore_global

# Symlink ctags globbal config
rm -rf $HOME/.ctags
ln -s $HOME/.dotfiles/.ctags $HOME/.ctags

# Set global giignore
git config --global core.excludesfile ~/.gitignore_global

# Set macOS preferences
# We will run this last because this will reload the shell
source .macos
