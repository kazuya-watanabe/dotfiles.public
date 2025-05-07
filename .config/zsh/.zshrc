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

type sheldon >/dev/null 2>&1 && eval "$(sheldon source)"

autoload -U compinit
compinit

test -r "${ZDOTDIR}/.aliases" >/dev/null 2>&1 && source "${ZDOTDIR}/.aliases"

setopt auto_cd
setopt auto_name_dirs
setopt auto_pushd
setopt bang_hist
setopt correct
setopt extended_history
setopt hist_fcntl_lock
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt inc_append_history
setopt magic_equal_subst
setopt notify
setopt pushd_ignore_dups
setopt share_history

zstyle ':completion:*' menu true select list-colors

autoload -U history-search-end

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

HISTFILE="${HOME}/.config/zsh/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-beginning-search-forward-end history-beginning-search-backward-end)

bindkey -M vicmd 'j'  history-beginning-search-forward-end
bindkey -M vicmd 'k'  history-beginning-search-backward-end
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^B' backward-char
bindkey -M viins '^D' delete-char-or-list
bindkey -M viins '^E' end-of-line
bindkey -M viins '^F' forward-char
bindkey -M viins '^G' send-break
bindkey -M viins '^H' backward-delete-char
bindkey -M viins '^K' kill-line
bindkey -M viins '^N' history-beginning-search-forward-end
bindkey -M viins '^P' history-beginning-search-backward-end
bindkey -M viins '^R' history-incremental-search-backward
bindkey -M viins '^S' history-incremental-search-forward
bindkey -M viins '^U' backward-kill-line
bindkey -M viins '^W' backward-kill-word
bindkey -M viins '^Y' yank

type fzf >/dev/null 2>&1 && source <(fzf --zsh)

if type gdircolors >/dev/null 2>&1; then
  eval "$(gdircolors -b)"
elif type dircolors >/dev/null 2>&1; then
  eval "$(dircolors -b)"
fi
