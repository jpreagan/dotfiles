source $ZDOTDIR/plugins.zsh

setopt histignorealldups sharehistory

# Use vi keybindings
bindkey -v

# Keep 10000 lines of history within the shell and save it to ~/.config/zsh/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$ZDOTDIR/.zsh_history

fpath=(${ZDOTDIR}/.zsh/zsh-completions/src(N) $fpath)

# Homebrew
if (( ! $+commands[brew] )); then
  test -d /opt/homebrew/bin && eval "$(/opt/homebrew/bin/brew shellenv)"
  test -d /home/linuxbrew/.linuxbrew/bin && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
fpath=(/opt/homebrew/share/zsh/site-functions(N) /home/linuxbrew/.linuxbrew/share/zsh/site-functions(N) ${fpath})

fpath=(${XDG_DATA_HOME}/zsh/site-functions(N) ${fpath})

# Rust
if [ -d "$HOME/.cargo/bin" ] ; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi
if (( $+commands[rustup] )); then
  fpath=(${HOME}/.rustup/toolchains/stable-aarch64-apple-darwin/share/zsh/site-functions(N) ${fpath})
fi

# Python
if [ -d "/Library/Frameworks/Python.framework/Versions/3.12/bin" ] ; then
    export PATH="/Library/Frameworks/Python.framework/Versions/3.12/bin:$PATH"
fi

# Miniconda
__conda_setup="$("$HOME/miniconda3/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
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
if (( $+commands[conda] )); then
  source $ZDOTDIR/.zsh/conda-zsh-completion/conda-zsh-completion.plugin.zsh
fi

# asdf
source $ZDOTDIR/asdf.zsh

# Use modern completion system
autoload -Uz compinit
compinit

source "$ZDOTDIR/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$ZDOTDIR/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh"
source "$ZDOTDIR/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"

for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/.local/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/.local/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/.local/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/.local/google-cloud-sdk/completion.zsh.inc"; fi

# Azure CLI completions
if (( $+commands[az] )); then
  autoload bashcompinit && bashcompinit
  source $(brew --prefix)/etc/bash_completion.d/az
fi

if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if (( ${+commands[eza]} )); then
  alias ls='eza'
elif (( ${+commands[exa]} )); then
  alias ls='exa'
else
  alias ls='ls --color=auto'
fi

alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias ll='ls -l --color=auto'
alias lla='ls -la --color=auto'
alias xzegrep='xzegrep --color=auto'
alias xzfgrep='xzfgrep --color=auto'
alias xzgrep='xzgrep --color=auto'
alias zegrep='zegrep --color=auto'
alias zfgrep='zfgrep --color=auto'
alias zgrep='zgrep --color=auto'

alias vi='nvim'
alias vim='nvim'

alias py='python3'
alias python='python3'
alias pip='pip3'

if (( ${+commands[starship]} )); then
  eval "$(starship init zsh)"
fi