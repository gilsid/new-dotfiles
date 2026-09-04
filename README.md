# dotfiles

Personal dotfiles for Arch + Hyprland. Managed with GNU Stow.

## Inside

- hypr, waybar, rofi, mako, ghostty, alacritty, tmux
- nvim, yazi, doom, fastfetch
- gtk, kvantum, qt5ct/qt6ct, matugen
- zshrc + `utopia.zsh-theme` (oh-my-zsh, gruvbox material dark)
- wallpapers, herdr

Each folder is a Stow package. Stow creates symlinks to `~/.config` and `~/`.

## Requirements

- `stow`, `git`
- `hyprland` + `waybar`, `rofi`, `mako` (for desktop)
- `ghostty` or `alacritty`, `tmux`, `neovim`, `yazi`, `fastfetch`
- `zsh`, `oh-my-zsh` if you use the zsh theme

## Quick start

```bash
git clone https://github.com/gilsid/new-dotfiles ~/new-dotfiles
cd ~/new-dotfiles

stow -n -v hypr               # dry run, check for conflicts
stow hypr                     # link one package
stow nvim ghostty tmux zshrc  # link several at once
stow */                      # link everything
stow -D hypr                 # unlink a package
```

`zshrc` is special: `zshrc/.zshrc` links to `~/.zshrc`, `utopia.zsh-theme` links to `~/.oh-my-zsh/themes/utopia.zsh-theme`. Requires oh-my-zsh installed.

If `~/.config/hypr` already exists, back it up first. Stow will not overwrite.

## Update

```bash
git pull
stow -R */                    # re-link everything
```
