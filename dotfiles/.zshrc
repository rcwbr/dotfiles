#!/bin/zsh

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# shellcheck disable=SC2034
plugins=(autojump docker fzf git pre-commit pyenv ssh thefuck tmux)

if [[ "$AUTOJUMP_SOURCED" != "1" ]]; then
  # shellcheck source=/dev/null
  . /usr/share/autojump/autojump.zsh
fi

# shellcheck disable=SC2034
ZSH_THEME="re5et"

# shellcheck source=/dev/null
source "$ZSH/oh-my-zsh.sh"

# shellcheck source=dotfiles/.shell_common.sh
source "$HOME/.shell_common.sh"
