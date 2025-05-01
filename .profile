export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export TZ=Asia/Tokyo

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"
export PATH="${HOME}/.local/bin":"/opt/homebrew/bin":"/opt/homebrew/sbin":${PATH}

umask 0022

# bat
type bat >/dev/null 2>&1 && export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'" && export MANROFFOPT='-c'

# fnm
type fnm >/dev/null 2>&1 && eval "$(fnm env --use-on-cd)"

# fzf
export FZF_DEFAULT_COMMAND='fd --hidden --follow --type f'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --preview "bat --color=always --style-numbers --line-range=:500 {}"'
export FZF_CTRL_T_COMMAND='fd --hidden --follow --type f'
export FZF_CTRL_T_OPTS='--height 40% --layout=reverse --preview "bat --color=always {}"'

# less
export PAGER=less
export LESS=-iFJMRX
export LESSOPEN='| lesspipe.sh %s'
export LESS_ADVANCED_PREPROCESSOR=1

# python3
export PYTHONUSERBASE="${HOME}/.local"

# ripgrep
export RIPGREP_CONFIG_PATH="${HOME}/.config/rg/ripgreprc"

# vim
export EDITOR=vim
export VISUAL=vim

# zsh
export ZDOTDIR="${HOME}/.config/zsh"

uname=$(uname -s)

if [ $uname='Darwin' ]; then
  export COPY_EXTENDED_ATTRIBUTES_DISABLE=1
  export COPYFILE_DISABLE=1
  export SDKROOT='/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk'
  export _JAVA_OPTIONS='-Dfile.encoding=UTF-8'
fi

if [ $uname='Linux' ]; then
  export XMODIFIERS='@im=ibus'
  export GTK_IM_MODULE=ibus
  export QT_IM_MODULE=ibus
fi
