set -gx EDITOR nvim
set -gx VISUAL $EDITOR

if command -q bat
    set -gx PAGER bat
else if command -q batcat
    set -gx PAGER batcat
else
    set -gx PAGER less
end

# Go
if test -d /usr/local/go
    set -gx GOROOT /usr/local/go
    fish_add_path --path /usr/local/go/bin
end

if test -d $HOME/go/bin
    set -gx GOBIN $HOME/go/bin
    fish_add_path --path $GOBIN
end

# Rust
if test -f $HOME/.cargo/env.fish
    source $HOME/.cargo/env.fish
end

# Google Cloud SDK path
if test -f $HOME/.local/google-cloud-sdk/path.fish.inc
    source $HOME/.local/google-cloud-sdk/path.fish.inc
end

# OpenCode
if test -d $HOME/.opencode/bin
    fish_add_path --path $HOME/.opencode/bin
end

# Soar
if test -d $HOME/.local/share/soar/bin
    fish_add_path --path $HOME/.local/share/soar/bin
end

if test -d $HOME/.local/bin
    fish_add_path --path $HOME/.local/bin
end

if status is-interactive
    set -g fish_greeting
    fish_vi_key_bindings

    # Google Cloud SDK completions
    complete -c gcloud -f -a '(__fish_argcomplete_complete gcloud)'
    complete -c gsutil -f -a '(__fish_argcomplete_complete gsutil)'

    # AWS CLI completion
    if command -q aws; and command -q aws_completer
        complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
    end

    # Azure CLI completion
    if command -q az
        complete --command az --no-files --arguments '(__fish_argcomplete_complete az)'
    end

    if command -q starship
        starship init fish | source
    end
end
