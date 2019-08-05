#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../../../lib/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main () {
    log_arrow "Browsers"

    cask_install "firefox"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main
