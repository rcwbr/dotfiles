TARGET_SHELL="sh"

# Determine shell to target
BASH_EXECUTABLE_PATH=/bin/bash
if which bash > /dev/null; then
  BASH_EXECUTABLE_PATH=$(which bash)
fi
if [ -f "$BASH_EXECUTABLE_PATH" ]; then
  TARGET_SHELL="$BASH_EXECUTABLE_PATH"
fi

ZSH_EXECUTABLE_PATH=/bin/zsh
if which zsh > /dev/null; then
  ZSH_EXECUTABLE_PATH=$(which zsh)
fi
if [ -f "$ZSH_EXECUTABLE_PATH" ]; then
  TARGET_SHELL="$ZSH_EXECUTABLE_PATH"
fi
export TARGET_SHELL

# If tmux is already not in use, attempt to switch to it
# Otherwise, do nothing to avoid colliding with its configuration
case $- in
  *i*)
    if [ -z ${TMUX+x} ]; then
      # If tmux is available, switch to it
      TMUX_EXECUTABLE_PATH=/bin/tmux
      if which tmux > /dev/null; then
        TMUX_EXECUTABLE_PATH=$(which tmux)
      fi
      if [ -f "$TMUX_EXECUTABLE_PATH" ]; then
        # If a VSCode terminal
        if [ "${TERM_PROGRAM}" == "vscode" ]; then
          if [ -n "$SSH_CONNECTION" ] && [ -z "$VSCODE_INJECTION" ]; then
            # VSCode SSH connection, but not VSCode injection
            echo "Not SSH or VSCode, proceeding as local interactive shell."
          else
            # VSCode injection or non-SSH
            exec "$TMUX_EXECUTABLE_PATH"
            exit
          fi
        fi
      fi
    fi
    ;;
esac

# Otherwise, switch to the target shell directly, if not already in use
if [ "$SHELL" != "$TARGET_SHELL" ]; then
  export SHELL="$TARGET_SHELL"
  exec "$TARGET_SHELL" -l
  exit
fi
