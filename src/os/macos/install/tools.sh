#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../../../lib/utils.sh"

main () {
    log_header "Tools"

    brew_install "fzf"
    brew_install "the_silver_searcher"
    brew_install "htop"

    brew_install "tldr"
    brew_install "wget"

}

main
