function ls --wraps ls --description 'List files (using eza/exa if available)'
    if command -sq eza
        eza $argv
    else if command -sq exa
        exa $argv
    else
        command ls $argv
    end
end
