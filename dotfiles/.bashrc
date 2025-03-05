#!/bin/bash

# shellcheck source=dotfiles/.shell_common.sh
source "$HOME/.shell_common.sh"

ZSH_EXECUTABLE_PATH=/bin/zsh
if [ "$SHELL" != "$ZSH_EXECUTABLE_PATH" ] && [ -f "$ZSH_EXECUTABLE_PATH" ]; then
  export SHELL="$ZSH_EXECUTABLE_PATH"
  exec "$ZSH_EXECUTABLE_PATH" -l
  exit
fi
