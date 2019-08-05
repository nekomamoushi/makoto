#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../../../lib/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main () {
    log_arrow "Misc"

    cask_install "iina"
    cask_install "numi"
    cask_install "transmission"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main
