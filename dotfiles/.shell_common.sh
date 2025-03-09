#!/bin/bash

# Shell configuration agnostic of the shell tool

export GHCR_USERNAME=rcwbr
# shellcheck source=dotfiles/.aliases.sh
source "$HOME/.aliases.sh"

code_dump_to_clipboard () {
  "$HOME/.code_dump_to_clipboard"
}
