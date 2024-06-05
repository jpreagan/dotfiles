export ZDOTDIR="$HOME/.config/zsh"
if [ ! -d "$ZDOTDIR" ]; then
    mkdir -p "$ZDOTDIR"
fi
if [ ! -f "$ZDOTDIR/.zshenv" ]; then
    touch "$ZDOTDIR/.zshenv"
fi
source "$ZDOTDIR/.zshenv"