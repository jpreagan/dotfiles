# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Alias definitions.
if command -v eza &> /dev/null; then
alias ls='eza'
    alias la='ls -a'
    alias lla='ls -la'
elif command -v exa &> /dev/null; then
    alias ls='exa'
    alias la='ls -a'
    alias lla='ls -la'
else
    alias la='ls -A'
    alias lla='ls -lA'
fi
alias ll='ls -l'

alias vi='nvim'
alias vim='nvim'

alias py='python3'
alias python='python3'
alias pip='pip3'

[[ $- == *i* ]] && source "$HOME/.local/share/blesh/ble.sh" --noattach

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# rust
if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
CONDA_ROOT=~/miniconda3
if [[ -r "${CONDA_ROOT}/etc/profile.d/bash_completion.sh" ]]; then
    source "${CONDA_ROOT}/etc/profile.d/bash_completion.sh"
fi

# pipx completions
if command -v register-python-argcomplete >/dev/null 2>&1; then
    eval "$(register-python-argcomplete pipx)"
fi

# aws cli completions
if command -v aws &> /dev/null; then
    complete -C "$(command -v aws_completer)" aws
fi
# asdf
if [ -f "$HOME/.asdf/asdf.sh" ]; then
  . "$HOME/.asdf/asdf.sh"
fi
if [ -f "$HOME/.asdf/completions/asdf.bash" ]; then
  . "$HOME/.asdf/completions/asdf.bash"
fi

# nvim
if [ -d "/opt/nvim" ] ; then
  export PATH="$PATH:/opt/nvim"
fi

# add private bin to PATH
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# starship
if command -v starship &> /dev/null; then
  eval "$(starship init bash)"
fi

[[ ${BLE_VERSION-} ]] && ble-attach
