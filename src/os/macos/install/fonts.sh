#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../../../lib/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main () {
    log_arrow "Fonts"

    cask_install "font-iosevka"
    cask_install "font-fira-code"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main
