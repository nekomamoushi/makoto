#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../../../lib/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main () {
    log_header "Git"

    brew_install "git"
    brew_install "diff-so-fancy"
    brew_install "git-standup"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main
