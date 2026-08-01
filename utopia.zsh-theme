# vim:ft=zsh ts=2 sw=2 sts=2
# Agnoster Theme - Catppuccin Macchiato Version (With Full Date & Time)

### Catppuccin Macchiato Colors (256-color palette)
CP_BASE=236
CP_SURFACE1=240
CP_TEXT=253
CP_MAUVE=183
CP_RED=203
CP_PEACH=209
CP_YELLOW=221
CP_GREEN=149
CP_SAPPHIRE=110
CP_BLUE=111
CP_LAVENDER=146
CP_TEAL=116

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
    prompt_segment $CP_MAUVE $CP_BASE "%{$fg_bold[$CP_BASE]%}$USER@%m%{$fg_no_bold[$CP_BASE]%}"
  else
    prompt_segment $CP_LAVENDER $CP_BASE "%{$fg_bold[$CP_BASE]%}@$USER%{$fg_no_bold[$CP_BASE]%}"
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
    
    bgclr=$CP_GREEN
    fgclr=$CP_BASE
    clean=' ✔'

    if [[ -n $dirty ]]; then
      clean=''
      bgclr=$CP_PEACH 
    fi

    local current_commit_hash=$(git rev-parse HEAD 2> /dev/null)
    local number_of_untracked_files=$(\grep -c "^??" <<< "${git_status}")
    if [[ $number_of_untracked_files -gt 0 ]]; then untracked=" $number_of_untracked_files☀"; fi

    local number_added=$(\grep -c "^A" <<< "${git_status}")
    if [[ $number_added -gt 0 ]]; then added=" $number_added✚"; fi

    local number_modified=$(\grep -c "^.M" <<< "${git_status}")
    if [[ $number_modified -gt 0 ]]; then
      modified=" $number_modified●"
      bgclr=$CP_RED 
    fi

    local number_deleted=$(\grep -c "^.D" <<< "${git_status}")
    if [[ $number_deleted -gt 0 ]]; then
      deleted=" $number_deleted‒"
      bgclr=$CP_RED
    fi

    prompt_segment $bgclr $fgclr
    print -n "%{$fg_bold[$fgclr]%}${ref/refs\/heads\//$PL_BRANCH_CHAR }${mode}$clean$untracked$modified$deleted$added%{$fg_no_bold[$fgclr]%}"
  fi
}

prompt_dir() {
  prompt_segment $CP_SAPPHIRE $CP_BASE "%{$fg_bold[$CP_BASE]%}%~%{$fg_no_bold[$CP_BASE]%}"
}

prompt_virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path ]]; then
    prompt_segment $CP_BLUE $CP_BASE "(`basename $virtualenv_path`)"
  fi
}

# Bagian Waktu dengan format: Fri 16 Jan - 14:25
prompt_time() {
  prompt_segment $CP_SURFACE1 $CP_TEXT "%D{%a %e %b - %H:%M}"
}

prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{$CP_RED}%}$CROSS"
  [[ $UID -eq 0 ]] && symbols+="%{%F{$CP_YELLOW}%}$LIGHTNING"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{$CP_TEAL}%}$GEAR"

  [[ -n "$symbols" ]] && prompt_segment $CP_BASE default "$symbols"
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
