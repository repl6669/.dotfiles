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

# Setup PHP & Laravel
sudo pecl install imagick # Install PHP extensions with PECL
/usr/local/bin/composer global require laravel/installer laravel/valet # Install global Composer packages
$HOME/.composer/vendor/bin/valet install # Install Laravel Valet

# Create projects directories
mkdir $HOME/Developer # This is a default directory for macOS user accounts but doesn't come pre-installed
mkdir $HOME/Developer/php # Create sites subdirectories

# Setup ZSH
rm -rf $HOME/.zshrc # Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Symlink neovim config files
ln -s $HOME/.dotfiles/.config/nvim $HOME/.config/nvim

# Symlink lazygit config file
ln -s $HOME/.dotfiles/lazygit.yml '/Users/theimer/Library/Application Support/jesseduffield/lazygit/config.yml'

# Symlink pint config file
ln -s $HOME/.dotfiles/pint.json $HOME/.config/pint.json

# Symlink the Mackup config file to the home directory
rn -rf $HOME/.mackup.cfg
ln -s $HOME/.dotfiles/.mackup.cfg $HOME/.mackup.cfg

rm -rf $HOME/.gitignore_global # Remove defaiult global gitignore before symlink
ln -s $HOME/.dotfiles/.gitignore_global $HOME/.gitignore_global # Symlink global gitignore file
ln -s $HOME/.dotfiles/.ripgreprc $HOME/.config/.ripgreprc # Symlink global ripgrep config file

# Set global giignore
git config --global core.excludesfile ~/.gitignore_global

# Set macOS preferences
# We will run this last because this will reload the shell
source .macos
