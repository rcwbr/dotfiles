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

# Custom Docker aliases
alias drrieb="docker run --rm -it --entrypoint bash"
alias drrie="docker run --rm -it --entrypoint "
alias drri="docker run --rm -it"
alias drr="docker run --rm"
