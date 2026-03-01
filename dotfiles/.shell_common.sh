#!/bin/bash

# Shell configuration agnostic of the shell tool

export ANTHROPIC_AUTH_TOKEN="ollama"
export ANTHROPIC_API_KEY=""
export ANTHROPIC_BASE_URL="http://localhost:11434"
export ANTHROPIC_MODEL="qwen3-coder-next:cloud"

# Perform host-specific setup, such as secrets that may not be checked into the repository
HOST_SETUP_SCRIPT=$HOME/.host_setup.sh
if [ -f "$HOST_SETUP_SCRIPT" ]; then
  # shellcheck source=/dev/null
  source "$HOST_SETUP_SCRIPT"
fi

export GHCR_USERNAME=rcwbr
# shellcheck source=dotfiles/.aliases.sh
source "$HOME/.aliases.sh"

export PATH="${HOME}/.local/bin:${PATH}"

code_dump_to_clipboard () {
  "$HOME/.code_dump_to_clipboard"
}

code_save_extensions () {
  # Exclude extensions that Codespaces already provides
  # And exclude extensions that are already installed in the devcontainer
  code --list-extensions \
    | grep -v -e Extensions -e github.codespaces -e github.github-vscode-theme -e github.vscode-pull-request-github \
    | grep -v -F -f <(sed -n 's/^[[:space:]]*"\(.*\)",\?[[:space:]]*$/\1/p' .devcontainer/devcontainer.json) \
    > "$HOME/.vscode_extensions"
}

code_install_extensions () {
  # Settings sync will automatically install extensions. This function can be called to correct the sync state from source.
  xargs -n 1 code --install-extension < "$HOME/.vscode_extensions"
}
