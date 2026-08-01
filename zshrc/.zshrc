# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="utopia"

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

plugins=(
	git
	archlinux
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Check archlinux plugin commands here
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/archlinux

# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
#pokemon-colorscripts --no-title -s -r #without fastfetch
#pokemon-colorscripts --no-title -s -r | fastfetch -c $HOME/.config/fastfetch/config-pokemon.jsonc --logo-type file-raw --logo-height 10 --logo-width 5 --logo -

# fastfetch. Will be disabled if above colorscript was chosen to install
fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

# Set-up icons for files/directories in terminal using lsd
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

# Buat Alias untuk shortcut
alias up='paru -Syu'
alias vim='nvim'
alias v='nvim'
alias s='paru -Ss'
# Alias for RTK Antigravity
alias ag='rtk init --agent antigravity'
# 9 router alias
alias start9router="source $HOME/env-penting/.env9router && 9router"

# VI MODE
bindkey -v
# FZF
source <(fzf --zsh)
fzf-files() {
	local file
	file=$(fd -H -t f . | fzf --preview 'bat --style=numbers --color=always {}')
	[[ -n "$file" ]] && LBUFFER+="$file"
}
zle -N fzf-files
# INSERT MODE (viins)
bindkey -M viins '^F' fzf-files
bindkey -M viins '^R' fzf-history-widget
# NORMAL MODE (optional tapi enak)
bindkey -M vicmd '^F' fzf-files
bindkey -M vicmd '^R' fzf-history-widget

# Alias untuk mount Linux mint
alias mount-mint='udisksctl mount -b /dev/sda5'
alias unmount-mint='udisksctl unmount -b /dev/sda5'
alias mount-void='udisksctl mount -b /dev/sda3'
alias unmount-void='udisksctl unmount -b /dev/sda3'
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt correct
setopt AUTO_CD

# yt-dlp
yt() {
	if [[ "$1" == "-a" ]]; then
		if [[ -z "$2" ]]; then
			echo "Penggunaan: yt -a <URL>"
		else
			yt-dlp -x --audio-format mp3 -P "$HOME/Music" "$2"
		fi
	else
		yt-dlp -P "$HOME/Videos" "$1"
	fi
}

# Set Neovim sebagai default editor
export EDITOR=nvim
export VISUAL=nvim
export SUDO_EDITOR=nvim

# PATH
# Gemini
export PATH="$HOME/.bun/bin:$PATH"
# Laravel
export PATH="$PATH:$HOME/.config/composer/vendor/bin"
# Flutter
export PATH="$HOME/develop/flutter/bin:$PATH"
# Doom Emacs
export PATH="$HOME/.config/emacs/bin:$PATH"
# NPM global for 9router
export PATH="$HOME/.npm-global/bin:$PATH"
# Local
export PATH="$HOME/.local/bin:$PATH"
# NOTE
echo "Boot.dev sudah sampai chapter 9 : Lists Level 1"

# Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd <"$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Zoxide
eval "$(zoxide init zsh)"
