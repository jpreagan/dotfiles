set -gx EDITOR nvim
set -gx VISUAL $EDITOR

if command -q bat
    set -gx PAGER bat
else if command -q batcat
    set -gx PAGER batcat
else
    set -gx PAGER less
end

# Homebrew
if not command -q brew
    if test -x /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv)
    end
end

# Go
if test -d $HOME/go/bin
    set -gx GOBIN $HOME/go/bin
    fish_add_path --path $GOBIN
end

# Rust
if test -f $HOME/.cargo/env.fish
    source $HOME/.cargo/env.fish
end

# Python
if test -d /Library/Frameworks/Python.framework/Versions/Current/bin
    fish_add_path --path /Library/Frameworks/Python.framework/Versions/Current/bin
end

# pnpm
set -gx PNPM_HOME $HOME/Library/pnpm
if test -d $PNPM_HOME
    fish_add_path --path $PNPM_HOME
end

# OpenCode
if test -d $HOME/.opencode/bin
    fish_add_path --path $HOME/.opencode/bin
end

# LM Studio
if test -d $HOME/.lmstudio/bin
    fish_add_path --path $HOME/.lmstudio/bin
end

if test -d $HOME/.local/bin
    fish_add_path --path $HOME/.local/bin
end

if status is-interactive
    set -g fish_greeting
    fish_vi_key_bindings

    if command -q starship
        starship init fish | source
    end
end
