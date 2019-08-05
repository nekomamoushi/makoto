#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../../../lib/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main () {
    log_header "Development"

    cask_install "iterm2"
    cask_install "sublime-merge"

    cask_install "android-studio"
    cask_install "android-platform-tools"
    cask_install "android-sdk"
    cask_install "adoptopenjdk8"


    brew_install "python@2"
    brew_install "python"
    brew_install "pyenv"
    brew_install "pipenv"

    brew_install "nvm"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main
