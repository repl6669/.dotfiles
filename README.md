# .dotfiles

Personal .dotfiles

Special thanks to [Dries Vints](https://github.com/driesvints) for making a great dotfiles [tutorial](https://driesvints.com/blog/getting-started-with-dotfiles) and [screencast](https://laracasts.com/series/guest-spotlight/episodes/1).

## What's in here

| File | What it does |
| --- | --- |
| `fresh.sh` | Full setup: Homebrew, Brewfile, Oh My Zsh, symlinks, Rust, Python, Valet, Neovim plugins, macOS prefs. Safe to re-run. |
| `Brewfile` | CLI tools, apps (casks), Mac App Store apps, global npm and cargo packages |
| `.macos` | System preferences (Dock, Finder, keyboard, trackpad, Spaces for AeroSpace) |
| `.mackup.cfg` | Allowlist of app settings synced through iCloud (`mackup backup` / `mackup restore`). Nothing from this repo is on it. |
| `.config/` | Neovim, Ghostty, AeroSpace, Zellij, lazygit, Claude Code, pi, ... (symlinked into `~/.config` and `~`) |

## Before you reinstall

Go through this list before you wipe the disk.

### Dotfiles

- [ ] Commit and push everything in `~/.dotfiles` (`git status` must be clean)
- [ ] `brew bundle dump --file=- --taps --formulae --casks --mas --npm --cargo` and compare with `Brewfile` for anything new
- [ ] `mackup backup` (copies app settings to iCloud), then check `~/Library/Mobile Documents/com~apple~CloudDocs/Mackup` has synced

### Secrets and keys

- [ ] `~/.gnupg`, if still needed
- [ ] Any extra `~/.s3cfg-*` files (mackup only covers `~/.s3cfg`)
- [ ] API keys live in 1Password. `secrets.zsh` maps env vars to `op://` references, configs only use the env vars. Check every referenced item exists in 1Password.

### Code and data

- [ ] Copy all of `~/Developer` to an external disk. `.env` files aren't in git, and a lot of repos have uncommitted work.
- [ ] Push repos with unpushed commits and check for repos without a remote
- [ ] Dump local MySQL databases you need: `mysqldump -uroot --all-databases > all.sql`
- [ ] `~/.git-stats` (git-stats commit history)
- [ ] `~/.claude-mem` (claude-mem memory database) and `~/.claude/projects` if you want old Claude Code sessions

### Apps

- [ ] Raycast: Settings → Advanced → Export (snippets, quicklinks, hotkeys)
- [ ] TablePlus: select all connections → right click → Export, tick "Include passwords" and set a passphrase. Passwords live in the local Keychain, so mackup only carries the connection list. Save the export to 1Password.
- [ ] FileZilla: mackup backs up `~/.config/filezilla/sitemanager.xml` (all sites + saved passwords). To be safe also copy the file itself or do File → Export.
- [ ] Little Snitch: export rules
- [ ] Sign out of iCloud, deauthorize Music, unpair Bluetooth devices if selling

### Installed by hand (not in Brewfile)

Ableton Live 12 Suite, FileZilla, Ivanti Secure Access, RME (ADI-2 Remote, DigiCheck NG, USB Flash Tool), Roland Cloud, Keydous Driver, ObinsKit, QMK Toolbox, Adobe Acrobat, Bambu Connect, Prusa drivers, Umbrel, mlx-dspark, CrossOver, TeamViewer, Autodesk Fusion, games (Steam).

## Setting up the new Mac

1. Install macOS cleanly ([Apple guide](https://support.apple.com/en-us/102664)), update to the latest version
2. Sign in to iCloud and the App Store, install 1Password and sign in
3. Clone the repo:
   ```sh
   xcode-select --install
   git clone https://github.com/repl6669/.dotfiles.git ~/.dotfiles
   ```
4. Run `~/.dotfiles/fresh.sh`
5. Wait for iCloud to sync Mackup, then `mackup restore`
6. Put back `~/Developer` and databases
7. Switch the remote to SSH once the key is in place: `git -C ~/.dotfiles remote set-url origin git@github.com:repl6669/.dotfiles.git`
8. Restart

### Manual steps

- Keyboard input sources: add Czech QWERTY next to U.S.
- Caps Lock → Escape: Keyboard → Keyboard Shortcuts… → Modifier Keys, once per keyboard
- Grant Accessibility permission to AeroSpace, Raycast, SwiftBar
- Raycast: import settings, set cmd + space (Spotlight shortcut is turned off by `.macos`)
- TablePlus: File → Import connections from the export saved in 1Password
- Claude Code: plugins are listed in `.config/.claude/settings.json`, run `claude` and install them from the marketplaces in `plugins/known_marketplaces.json`

### Neovim

`fresh.sh` runs `Lazy! restore`, which installs plugins at the versions in `lazy-lock.json`. On the first real start Mason installs the LSP servers, formatters and debuggers, and treesitter compiles its parsers. Give it a minute, then run `:checkhealth`.
