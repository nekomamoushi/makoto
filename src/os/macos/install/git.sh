#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../../../lib/utils.sh"

main () {
    log_header "Git"

    brew_install "git"
}

main
