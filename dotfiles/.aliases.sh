#!/bin/bash

# Custom git aliases
alias gl="git pull"
alias gri="git rebase -i"
alias glf='git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)'
alias gpu='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'

# Custom Docker aliases
alias drrieb="docker run --rm -it --entrypoint bash"
alias drri="docker run --rm -it"
alias drr="docker run --rm"
