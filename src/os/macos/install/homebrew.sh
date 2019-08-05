#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../../../lib/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

homebrew_install () {
    if ! has "brew" ; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        # Exit if, for some reason, Homebrew is not installed.
        log_exit $? "Homebrew installation"
    else
        log_warn "Homebrew already installed"
        return 0
    fi
}

homebrew_install
