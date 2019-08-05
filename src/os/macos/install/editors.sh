#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../../../lib/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main () {
    log_arrow "Misc"

    cask_install "sublime-text"
    cask_install "vscodium"
    cask_install "macdown"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main
