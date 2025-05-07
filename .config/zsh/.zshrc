typeset -U fpath FPATH

fpath=(
  '/opt/homebrew/share/zsh/site-functions'(N-/)
  '/opt/homebrew/share/zsh/vendor-completions'(N-/)
  '/usr/local/share/zsh/site-functions'(N-/)
  '/usr/local/share/zsh/vendor-completions'(N-/)
  '/usr/share/zsh/site-functions'(N-/)
  '/usr/share/zsh/vendor-completions'(N-/)
  ${fpath}
  )

if [ -r "${ZPLUG_HOME:=~/.local/zplug}/init.zsh" ]; then
  source "${ZPLUG_HOME}/init.zsh"
else
  echo 'zplug not found. Installing...'
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

  if [ $? -ne 0 ]; then
    echo 'Failed to install zplug. Please install it manually.' >&2
  else
    echo 'zplug installed successfully. Please restart your shell.'
    read
    exit 1
  fi
fi

zplug 'spaceship-prompt/spaceship-prompt', use:spaceship.zsh, as:theme
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-history-substring-search'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

setopt auto_list
setopt auto_menu
setopt auto_remove_slash
setopt list_types
setopt hash_list_all

setopt extended_history
setopt hist_fcntl_lock
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_functions
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt inc_append_history
setopt share_history

setopt correct
setopt correct_all
setopt hash_cmds
setopt hash_dirs

zstyle ':completion:*' menu true select list-colors

HISTFILE="${ZDOTDIR}/.zsh_history"
HISTSIZE=10000
SAVEHIST=20000

bindkey -M vicmd '^N' history-substring-search-down
bindkey -M vicmd '^P' history-substring-search-up
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^B' backward-char
bindkey -M viins '^D' delete-char-or-list
bindkey -M viins '^E' end-of-line
bindkey -M viins '^F' forward-char
bindkey -M viins '^G' send-break
bindkey -M viins '^H' backward-delete-char
bindkey -M viins '^K' kill-line
bindkey -M viins '^N' history-substring-search-down
bindkey -M viins '^P' history-substring-search-up
bindkey -M viins '^U' backward-kill-line
bindkey -M viins '^W' backward-kill-word

test -r "${ZDOTDIR}/.aliases" && source "${ZDOTDIR}/.aliases"

type fzf >/dev/null && source <(fzf --zsh)
type zoxide >/dev/null && eval "$(zoxide init zsh)"

if type gdircolors >/dev/null 2>&1; then
  eval "$(gdircolors -b)"
elif type dircolors >/dev/null 2>&1; then
  eval "$(dircolors -b)"
fi
