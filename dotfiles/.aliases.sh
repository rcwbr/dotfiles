#!/bin/bash

# Custom git aliases
alias gcm="git commit -m "
alias gkl="git clean -fd"
alias gkld="git clean -n -fd"
alias gl="git pull"
alias gri="git rebase -i"
alias gdo='git diff origin/$(git rev-parse --abbrev-ref HEAD)'
alias glf='git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)'
alias gpu='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'

# shellcheck disable=SC2016
WORKING_DIR_MOUNT='-v $(pwd):$(pwd) -w $(pwd)'

# Custom Docker aliases

alias drrieb="docker run --rm -it --entrypoint bash"
# shellcheck disable=SC2139
alias drriebw="docker run --rm -it ${WORKING_DIR_MOUNT} --entrypoint bash"

alias drrie="docker run --rm -it --entrypoint "
# shellcheck disable=SC2139
alias drriew="docker run --rm -it ${WORKING_DIR_MOUNT} --entrypoint "

alias drri="docker run --rm -it"
# shellcheck disable=SC2139
alias drriw="docker run --rm -it ${WORKING_DIR_MOUNT}"

alias drr="docker run --rm"
# shellcheck disable=SC2139
alias drrw="docker run --rm ${WORKING_DIR_MOUNT}"
