#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../../../lib/utils.sh"

main () {
    log_header "Quick Look Plugins"

    brew_install "qlcolorcode"
    brew_install "qlmarkdown"
    brew_install "quicklook-json"
    brew_install "quicklook-csv"
    brew_install "qlstephen"
}

main
