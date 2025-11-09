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
# shellcheck disable=SC2016
DOCKER_SOCKET_MOUNT='-v $(docker context inspect --format "{{.Endpoints.docker.Host}}" | sed "s|.*://||" | head -1):/var/run/docker.sock'

# Custom Docker aliases

alias drrieb="docker run --rm -it --entrypoint bash"
# shellcheck disable=SC2139
alias drriebs="docker run --rm -it ${DOCKER_SOCKET_MOUNT} --entrypoint bash"
# shellcheck disable=SC2139
alias drriebw="docker run --rm -it ${WORKING_DIR_MOUNT} --entrypoint bash"
# shellcheck disable=SC2139
alias drriebws="docker run --rm -it ${WORKING_DIR_MOUNT} ${DOCKER_SOCKET_MOUNT} --entrypoint bash"

alias drrie="docker run --rm -it --entrypoint "
# shellcheck disable=SC2139
alias drries="docker run --rm -it ${DOCKER_SOCKET_MOUNT} --entrypoint"
# shellcheck disable=SC2139
alias drriew="docker run --rm -it ${WORKING_DIR_MOUNT} --entrypoint "
# shellcheck disable=SC2139
alias drriews="docker run --rm -it ${WORKING_DIR_MOUNT} ${DOCKER_SOCKET_MOUNT} --entrypoint "

alias drri="docker run --rm -it"
# shellcheck disable=SC2139
alias drris="docker run --rm -it ${DOCKER_SOCKET_MOUNT}"
# shellcheck disable=SC2139
alias drriw="docker run --rm -it ${WORKING_DIR_MOUNT}"
# shellcheck disable=SC2139
alias drriws="docker run --rm -it ${WORKING_DIR_MOUNT} ${DOCKER_SOCKET_MOUNT}"

alias drr="docker run --rm"
# shellcheck disable=SC2139
alias drrs="docker run --rm ${DOCKER_SOCKET_MOUNT}"
# shellcheck disable=SC2139
alias drrw="docker run --rm ${WORKING_DIR_MOUNT}"
# shellcheck disable=SC2139
alias drrws="docker run --rm ${WORKING_DIR_MOUNT} ${DOCKER_SOCKET_MOUNT}"
