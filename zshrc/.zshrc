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

# VI MODE
bindkey -v
# FZF — guard biar tidak error jika fzf belum install, eval lebih portabel dari source <(...)
if command -v fzf >/dev/null 2>&1; then
	eval "$(fzf --zsh)"
fi
fzf-files() {
	local file
	# fallback ke find jika fd tidak ada, bat optional
	if command -v fd >/dev/null 2>&1; then
		file=$(fd -H -t f . 2>/dev/null | fzf --preview 'bat --style=numbers --color=always {} 2>/dev/null || cat {}')
	else
		file=$(find . -type f 2>/dev/null | fzf --preview 'bat --style=numbers --color=always {} 2>/dev/null || cat {}')
	fi
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

# Set Neovim sebagai default editor (sudo 1.9+ pakai EDITOR, SUDO_EDITOR deprecated)
export EDITOR=nvim
export VISUAL=nvim

# PATH — deduplicate, biar tidak dobel tiap source ~/.zshrc
typeset -U path PATH
path=(
	"$HOME/.local/bin"
	"$HOME/.bun/bin"
	"$HOME/develop/flutter/bin"
	"$HOME/.config/emacs/bin"
	"$HOME/.npm-global/bin"
	"$HOME/.config/composer/vendor/bin"
	$path
)
export PATH
# NODE_PATH => KHUSUS untuk Claude/agent (skill /docx), bukan untuk dipakai manual.
# Paket npm ke-install di ~/.npm-global/lib/node_modules.
export NODE_PATH="$HOME/.npm-global/lib/node_modules"
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
