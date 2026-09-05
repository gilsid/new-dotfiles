# vim:ft=zsh ts=2 sw=2 sts=2
# Agnoster Theme - Gruvbox Material Dark

GM_BG_DIM=233
GM_BG0=235
GM_BG3=237
GM_FG0=223
GM_RED=167
GM_ORANGE=208
GM_YELLOW=214
GM_GREEN=142
GM_AQUA=108
GM_BLUE=109
GM_PURPLE=175
GM_GREY0=243
GM_GREY2=246

CURRENT_BG='NONE'

# Characters
SEGMENT_SEPARATOR="\ue0b0"
PLUSMINUS="\u00b1"
BRANCH="\ue0a0"
DETACHED="\u27a6"
CROSS="\u2718"
LIGHTNING="\u26a1"
GEAR="\u2699"

# Begin a segment
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    print -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    print -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && print -n $3
}

# End the prompt
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    print -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    print -n "%{%k%}"
  fi
  print -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
prompt_context() {
  if [[ -n "$SSH_CLIENT" ]]; then
    prompt_segment $GM_PURPLE $GM_BG_DIM "%{$fg_bold[$GM_BG_DIM]%}$USER@%m%{$fg_no_bold[$GM_BG_DIM]%}"
  else
    prompt_segment $GM_AQUA $GM_BG_DIM "%{$fg_bold[$GM_BG_DIM]%}@$USER%{$fg_no_bold[$GM_BG_DIM]%}"
  fi
}

prompt_git() {
  local PL_BRANCH_CHAR
  () {
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    PL_BRANCH_CHAR="$BRANCH"
  }
  local ref dirty mode repo_path clean has_upstream
  local modified untracked added deleted tagged stashed
  local ready_commit git_status bgclr fgclr

  repo_path=$(git rev-parse --git-dir 2>/dev/null)

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    dirty=$(parse_git_dirty)
    git_status=$(git status --porcelain 2> /dev/null)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"
    
    bgclr=$GM_GREEN
    fgclr=$GM_BG_DIM
    clean=' ✔'

    if [[ -n $dirty ]]; then
      clean=''
      bgclr=$GM_ORANGE
    fi

    local current_commit_hash=$(git rev-parse HEAD 2> /dev/null)
    local number_of_untracked_files=$(\grep -c "^??" <<< "${git_status}")
    if [[ $number_of_untracked_files -gt 0 ]]; then untracked=" $number_of_untracked_files☀"; fi

    local number_added=$(\grep -c "^A" <<< "${git_status}")
    if [[ $number_added -gt 0 ]]; then added=" $number_added✚"; fi

    local number_modified=$(\grep -c "^.M" <<< "${git_status}")
    if [[ $number_modified -gt 0 ]]; then
      modified=" $number_modified●"
      bgclr=$GM_RED
    fi

    local number_deleted=$(\grep -c "^.D" <<< "${git_status}")
    if [[ $number_deleted -gt 0 ]]; then
      deleted=" $number_deleted‒"
      bgclr=$GM_RED
    fi

    prompt_segment $bgclr $fgclr
    print -n "%{$fg_bold[$fgclr]%}${ref/refs\/heads\//$PL_BRANCH_CHAR }${mode}$clean$untracked$modified$deleted$added%{$fg_no_bold[$fgclr]%}"
  fi
}

prompt_dir() {
  prompt_segment $GM_BLUE $GM_BG_DIM "%{$fg_bold[$GM_BG_DIM]%}%~%{$fg_no_bold[$GM_BG_DIM]%}"
}

prompt_virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path ]]; then
    prompt_segment $GM_YELLOW $GM_BG_DIM "(`basename $virtualenv_path`)"
  fi
}

prompt_time() {
  prompt_segment $GM_BG3 $GM_FG0 "%D{%a %e %b - %H:%M}"
}

prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{$GM_RED}%}$CROSS"
  [[ $UID -eq 0 ]] && symbols+="%{%F{$GM_YELLOW}%}$LIGHTNING"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{$GM_AQUA}%}$GEAR"

  [[ -n "$symbols" ]] && prompt_segment $GM_BG_DIM default "$symbols"
}

## Main prompt build
build_prompt() {
  RETVAL=$?
  print -n "\n"
  prompt_status
  prompt_time
  prompt_virtualenv
  prompt_dir
  prompt_git
  prompt_end
  CURRENT_BG='NONE'
  print -n "\n"
  prompt_context
  prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt) '

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=243"

zstyle ':completion:*' menu select
zstyle ':completion:*:*:*:*:*' menu select=1
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors "ma=38;5;233;48;5;214"

if (( ${+ZSH_HIGHLIGHT_STYLES} )); then
  ZSH_HIGHLIGHT_STYLES[default]='none'
  ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=167"
  ZSH_HIGHLIGHT_STYLES[reserved-word]="fg=214,bold"
  ZSH_HIGHLIGHT_STYLES[alias]="fg=#b8bb26,bold"
  ZSH_HIGHLIGHT_STYLES[suffix-alias]="fg=#b8bb26,bold"
  ZSH_HIGHLIGHT_STYLES[builtin]="fg=214"
  ZSH_HIGHLIGHT_STYLES[function]="fg=#b8bb26,bold"
  ZSH_HIGHLIGHT_STYLES[command]="fg=#b8bb26,bold"
  ZSH_HIGHLIGHT_STYLES[precommand]="fg=108,bold"
  ZSH_HIGHLIGHT_STYLES[hashed-command]="fg=108"
  ZSH_HIGHLIGHT_STYLES[path]="fg=223,underline"
  ZSH_HIGHLIGHT_STYLES[path_prefix]="fg=223,underline"
  ZSH_HIGHLIGHT_STYLES[globbing]="fg=175"
  ZSH_HIGHLIGHT_STYLES[history-expansion]="fg=108"
  ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=223"
  ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=223"
  ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]="fg=223"
  ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]="fg=109"
  ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]="fg=175"
  ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]="fg=167"
  ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]="fg=167"
  ZSH_HIGHLIGHT_STYLES[assign]="fg=223"
  ZSH_HIGHLIGHT_STYLES[comment]="fg=243"
  ZSH_HIGHLIGHT_STYLES[autodirectory]="fg=223,underline"
  ZSH_HIGHLIGHT_STYLES[cursor]="bg=223"
  ZSH_HIGHLIGHT_STYLES[region]="bg=237,fg=223"
fi

zle_highlight=(
  region:bg=237,fg=223
  special:fg=214,bold
  suffix:fg=223,underline
  isearch:bg=214,fg=233
  paste:bg=237,fg=223
)
