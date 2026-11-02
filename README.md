# .dotfiles

Personal .dotfiles

Special thanks to [Dries Vints](https://github.com/driesvints) for making a great dotfiles [tutorial](https://driesvints.com/blog/getting-started-with-dotfiles) and [screencast](https://laracasts.com/series/guest-spotlight/episodes/1).

## What's in here

| File | What it does |
| --- | --- |
| `fresh.sh` | Full setup: Homebrew, Brewfile, Oh My Zsh, symlinks, Rust, Python, Valet, Neovim plugins, macOS prefs. Safe to re-run. |
| `Brewfile` | CLI tools, apps (casks), Mac App Store apps, global npm and cargo packages |
| `.macos` | System preferences (Dock, Finder, keyboard, trackpad, Spaces for AeroSpace) |
| `.mackup.cfg` | App settings synced through iCloud. Ignores everything that lives in this repo. |
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
- [ ] `~/.kube/config`
- [ ] API keys live in 1Password. `secrets.zsh` maps env vars to `op://` references, configs only use the env vars. Check every referenced item exists in 1Password.

### Code and data

- [ ] Copy all of `~/Developer` to an external disk. `.env` files aren't in git, and a lot of repos have uncommitted work.
- [ ] Push repos with unpushed commits and check for repos without a remote
- [ ] Dump local MySQL databases you need: `mysqldump -uroot --all-databases > all.sql`
- [ ] `~/.git-stats` (git-stats commit history)
- [ ] `~/.claude-mem` (claude-mem memory database) and `~/.claude/projects` if you want old Claude Code sessions

### Fonts

- [ ] Copy `~/Library/Fonts` (~150 MB). Most are paid and not on Homebrew: TX-02 (Ghostty), Berkeley Mono, Comic Code, Dank Mono, Apercu, ...

### Apps

- [ ] Raycast: Settings → Advanced → Export (snippets, quicklinks, hotkeys)
- [ ] Little Snitch: export rules
- [ ] `~/SP404 User`, `~/Calibre Library`, `~/Screen Studio Projects`, `~/Movies`, `~/Pictures` if not in iCloud
- [ ] Parallels / CrossOver VMs and bottles you want to keep
- [ ] Licence keys for paid apps not bought through the App Store: Beyond Compare, Transmit, Sketch, Screen Studio, Tinkerwell, Ray, SoundSource, Audio Hijack, Little Snitch, Parallels, CrossOver
- [ ] Sign out of iCloud, deauthorize Music, unpair Bluetooth devices if selling

### Installed by hand (not in Brewfile)

Ableton Live 12 Suite, FileZilla, Ivanti Secure Access, RME (ADI-2 Remote, DigiCheck NG, USB Flash Tool), Roland Cloud, Keydous Driver, ObinsKit, QMK Toolbox, Adobe Acrobat, Bambu Connect, Prusa drivers, Umbrel, mlx-dspark, CrossOver, TeamViewer, Autodesk Fusion, games (Steam).

## Setting up the new Mac

1. Install macOS cleanly ([Apple guide](https://support.apple.com/en-us/102664)), update to the latest version
2. Sign in to iCloud and the App Store, install 1Password and sign in
3. Clone the repo:
   ```sh
   xcode-select --install
   git clone https://github.com/theimerj/.dotfiles.git ~/.dotfiles
   ```
4. Run `~/.dotfiles/fresh.sh`
5. Wait for iCloud to sync Mackup, then `mackup restore`
6. Put back fonts, SSH keys, `~/Developer`, databases
7. Switch the remote to SSH once the key is in place: `git -C ~/.dotfiles remote set-url origin git@github.com:theimerj/.dotfiles.git`
8. Restart

### Manual steps

- Keyboard input sources: add Czech QWERTY next to U.S.
- Grant Accessibility permission to AeroSpace, Raycast, AltTab, SwiftBar
- Raycast: import settings, set cmd + space (Spotlight shortcut is turned off by `.macos`)
- Claude Code: plugins are listed in `.config/.claude/settings.json`, run `claude` and install them from the marketplaces in `plugins/known_marketplaces.json`

### Neovim

`fresh.sh` runs `Lazy! restore`, which installs plugins at the versions in `lazy-lock.json`. On the first real start Mason installs the LSP servers, formatters and debuggers, and treesitter compiles its parsers. Give it a minute, then run `:checkhealth`.
