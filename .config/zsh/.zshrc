export ZPLUG_HOME=${ZPLUG_HOME:=~/.local/share/zplug}

if [ ! -r "${ZPLUG_HOME}/init.zsh" ]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

    if [ $? -ne 0 ]; then
        echo 'Failed to install zplug. Please install it manually.' >&2
        read
    fi
fi

if source "${ZPLUG_HOME}/init.zsh" 2>/dev/null; then
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
fi

test -x /home/linuxbrew/.linuxbrew/bin/brew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
test -x /opt/homebrew/bin/brew && eval $(/opt/homebrew/bin/brew shellenv)

typeset -U fpath FPATH

fpath=(
    '/opt/homebrew/share/zsh/site-functions'(N-/)
    '/home/linux/.linux/share/zsh/site-functions'(N-/)
    '/usr/local/share/zsh/site-functions'(N-/)
    '/usr/local/share/zsh/vendor-completions'(N-/)
    '/usr/share/zsh/site-functions'(N-/)
    '/usr/share/zsh/vendor-completions'(N-/)
    ${fpath}
)

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

setopt auto_list
setopt auto_menu
setopt auto_param_keys
setopt auto_param_slash
setopt list_types

setopt glob_dots

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

type gdircolors >/dev/null 2>&1 && eval "$(gdircolors -b)"

type fnm >/dev/null 2>&1 && eval "$(fnm env --use-on-cd)"

type fzf >/dev/null 2>&1 && source <(fzf --zsh)

type zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"
