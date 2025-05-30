umask 0022

export PATH="${HOME}/.local/bin":${PATH}
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"
export TMPDIR="${XDG_CACHE_HOME}/tmp"

export EDITOR=vim
export VISUAL=vim
export PAGER=less
export LESS=-iFJMRX
export LESSOPEN='| lesspipe.sh %s'
export LESS_ADVANCED_PREPROCESSOR=1
export FZF_DEFAULT_COMMAND='fd --hidden --follow --type f'
export FZF_DEFAULT_OPTS='--style full --height 40% --layout=reverse --preview "bat --color=always --style=plain --line-range=:500 {}"'
export PYTHONUSERBASE="${HOME}/.local"

export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export TZ=Asia/Tokyo

case $(uname) in
    Darwin)
        export COPY_EXTENDED_ATTRIBUTES_DISABLE=1
        export COPYFILE_DISABLE=1
        ;;
    Linux)
        export XMODIFIERS='@im=ibus'
        export GLFW_IM_MODULE=ibus
        export GTK_IM_MODULE=ibus
        export QT_IM_MODULE=ibus
        ;;
esac
