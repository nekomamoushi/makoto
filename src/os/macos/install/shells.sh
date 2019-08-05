#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../../../lib/utils.sh"

update_osx_shell_list () {
    # Add the new shell to the list of legit shells
    sudo bash -c "echo $1 >> /etc/shells"
}

change_osx_user_shell () {
    # Change the shell for the user
    chsh -s "$1"
}

main () {
    log_header "Shells"

    brew_install "bash"
    brew_install "bash-completion@2"
    brew_install "bash-git-prompt"
    brew_install "zsh"
    brew_install "zplug"

    update_osx_shell_list "/usr/local/bin/bash"
    update_osx_shell_list "/usr/local/bin/zsh"
    change_osx_user_shell "/usr/local/bin/bash"
}
