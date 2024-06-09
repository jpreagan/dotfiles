if [ -z "$XDG_CONFIG_HOME" ]; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi

if [ -z "$XDG_DATA_HOME" ]; then
    export XDG_DATA_HOME="$HOME/.local/share"
fi

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

if [ ! -d "$ZDOTDIR" ]; then
    mkdir -p "$ZDOTDIR"
fi

if [ ! -f "$ZDOTDIR/.zshenv" ]; then
    touch "$ZDOTDIR/.zshenv"
fi

source "$ZDOTDIR/.zshenv"