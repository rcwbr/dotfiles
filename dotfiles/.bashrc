#!/bin/bash

# shellcheck source=dotfiles/.shell_common.sh
source "$HOME/.shell_common.sh"

TARGET_SHELL="/bin/bash"
# Determine shell to target
ZSH_EXECUTABLE_PATH=/bin/zsh
if [ -f "$ZSH_EXECUTABLE_PATH" ]; then
  TARGET_SHELL="$ZSH_EXECUTABLE_PATH"
fi

# If tmux is already not in use, attempt to switch to it
# Otherwise, do nothing to avoid colliding with its configuration
if [ -z ${TMUX+x} ]; then
  # If tmux is available, switch to it
  TMUX_EXECUTABLE_PATH=/bin/tmux
  if [ -f "$TMUX_EXECUTABLE_PATH" ]; then
    export TARGET_SHELL
    exec "$TMUX_EXECUTABLE_PATH"
    exit
  fi

  # Otherwise, switch to the target shell directly, if not already in use
  if [ "$SHELL" != "$TARGET_SHELL" ]; then
    export SHELL="$TARGET_SHELL"
    exec "$TARGET_SHELL" -l
    exit
  fi
fi
