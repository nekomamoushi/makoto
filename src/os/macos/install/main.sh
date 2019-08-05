#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../../../lib/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main () {
    log_header "Install Applications"

    ./homebrew.sh
    ./shells.sh
    ./fonts.sh
    ./git.sh
    ./editors.sh
    ./development.sh
    ./tools.sh
    ./browsers.sh
    ./productivity.sh
    ./misc.sh
    ./quicklook.sh
}

main
