#!/bin/zsh

if [[ ! -e "$ZDOTDIR/.zsh/conda-zsh-completion" ]]; then
  git clone --depth=1 https://github.com/conda-incubator/conda-zsh-completion.git "$ZDOTDIR/.zsh/conda-zsh-completion"
fi
if [[ ! -e "$ZDOTDIR/.zsh/zsh-completions" ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-completions.git "$ZDOTDIR/.zsh/zsh-completions"
fi
if [[ ! -e "$ZDOTDIR/.zsh/zsh-syntax-highlighting" ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZDOTDIR/.zsh/zsh-syntax-highlighting"
fi
if [[ ! -e "$ZDOTDIR/.zsh/zsh-history-substring-search" ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search.git "$ZDOTDIR/.zsh/zsh-history-substring-search"
fi
if [[ ! -e "$ZDOTDIR/.zsh/zsh-autosuggestions" ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git "$ZDOTDIR/.zsh/zsh-autosuggestions"
fi
