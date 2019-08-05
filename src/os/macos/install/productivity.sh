#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../../../lib/utils.sh"

main () {
    log_header "Productivity"

    cask_install "1password"
    cask_install "evernote"
    cask_install "the-unarchiver"
    cask_install "boostnote"
}

main
