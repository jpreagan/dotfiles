if status is-interactive
    # Disable the greeting
    set -g fish_greeting

    # Enable vi key bindings
    fish_vi_key_bindings

    # Homebrew
    if not command -q brew
        if test -d /opt/homebrew/bin
            eval (/opt/homebrew/bin/brew shellenv)
        end
    end

    # Go
    if test -d $HOME/go/bin
        set -gx GOBIN $HOME/go/bin
        fish_add_path $GOBIN
    end

    # Rust
    if test -f $HOME/.cargo/env.fish
        source $HOME/.cargo/env.fish
    end

    # Python
    if test -d /Library/Frameworks/Python.framework/Versions/Current/bin
        set -x PATH "/Library/Frameworks/Python.framework/Versions/Current/bin" "$PATH"
    end

    # The next line updates PATH for the Google Cloud SDK.
    if [ -f "$HOME/.local/google-cloud-sdk/path.fish.inc" ]; . "$HOME/.local/google-cloud-sdk/path.fish.inc"; end

    # Google Cloud SDK Fish completions
    complete -c gcloud -f -a '(__fish_argcomplete_complete gcloud)'
    complete -c gsutil -f -a '(__fish_argcomplete_complete gsutil)'

    # AWS CLI
    if command -q aws
        complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
    end

    # Azure CLI
    if command -q az
        complete --command az --no-files --arguments '(__fish_argcomplete_complete az)'
    end

    if test -d $HOME/.local/bin
        set -gx PATH $HOME/.local/bin $PATH
    end

    # Launch starship
    starship init fish | source
end
