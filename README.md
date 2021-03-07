# .dotfiles

Personal .dotfiles

Special thanks to [Dries Vints](https://github.com/driesvints) for making a great dotfiles [tutorial](https://driesvints.com/blog/getting-started-with-dotfiles) and [screencast](https://laracasts.com/series/guest-spotlight/episodes/1).

## A Fresh macOS Setup

These instructions are for when you've already set up your dotfiles. If you want to get started with your own dotfiles you can [find instructions below](#your-own-dotfiles).

### Before you re-install

First, go through the checklist below to make sure you didn't forget anything before you wipe your hard drive.

- Did you backup your SSH keys to 1Password?
- Did you commit and push any changes/branches to your git repositories?
- Did you remember to save all important documents from non-iCloud directories?
- Did you save all of your work from apps which aren't synced through iCloud?
- Did you remember to export important data from your local database?
- Did you update [mackup](https://github.com/lra/mackup) to the latest version and ran `mackup backup`?

### Installing macOS cleanly

After going to our checklist above and making sure you backed everything up, we're going to cleanly install macOS with the latest release. Follow [this article](https://www.imore.com/how-do-clean-install-macos) to cleanly install the latest macOS version.

### Setting up your Mac

If you did all of the above you may now follow these install instructions to setup a new Mac.

1. Update macOS to the latest version with the App Store
2. Clone this repo to `~/.dotfiles`
3. Install [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh#getting-started)
4. Run `fresh.sh` to start the installation
5. After mackup is synced with your cloud storage, restore preferences by running `mackup restore`
6. Restart your computer to finalize the process

### Setting up Vim

1. Run `<Leader>pi` or `:PluginInstall` to install Plugins

Your Mac is now ready to use!
