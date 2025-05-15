umask 0022

export PATH="${HOME}/.local/bin":"${XDG_CONFIG_HOME}/composer/vendor/bin":${PATH}
export EDITOR=vim
export VISUAL=vim
export PAGER=less
export LESS=-iFJMRX
export LESSOPEN='| lesspipe.sh %s'
export LESS_ADVANCED_PREPROCESSOR=1
export FZF_DEFAULT_COMMAND='fd --hidden --follow --type f'
export FZF_DEFAULT_OPTS='--style full --height 40% --layout=reverse --preview "bat --color=always --style=plain --line-range=:500 {}"'
export PYTHONUSERBASE="${HOME}/.local"
export RIPGREP_CONFIG_PATH="${HOME}/.config/rg/ripgreprc"

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
