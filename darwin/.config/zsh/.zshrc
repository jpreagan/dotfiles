source $ZDOTDIR/plugins.zsh

setopt histignorealldups sharehistory

# Use vi keybindings
bindkey -v

# Keep 10000 lines of history within the shell and save it to ~/.config/zsh/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$ZDOTDIR/.zsh_history

fpath=(${ZDOTDIR}/.zsh/zsh-completions/src(N) $fpath)

source $ZDOTDIR/asdf.zsh

# Homebrew
if (( ! $+commands[brew] )); then
  test -d /opt/homebrew/bin && eval "$(/opt/homebrew/bin/brew shellenv)"
  test -d /home/linuxbrew/.linuxbrew/bin && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
fpath=(/opt/homebrew/share/zsh/site-functions(N) /home/linuxbrew/.linuxbrew/share/zsh/site-functions(N) ${fpath})

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

if [ -d "$HOME/.cargo/bin" ] ; then
    export PATH="$HOME/.cargo/bin:$PATH"
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
alias ll='ls -l --color=auto'
alias vi='nvim'
alias vim='nvim'

eval "$(starship init zsh)"
