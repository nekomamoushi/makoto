#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../../lib/utils.sh"

osx_available_updates () {
    tmp_file="$(mktemp /tmp/XXXXX)"
    softwareupdate -l &> "${tmp_file}"

    available=$(grep "\*" "${tmp_file}")
    if not_empty "${available}"; then
        return 0
    fi
    return 1
}

osx_install_update () {
    if available_osx_updates ; then
        ask_for_confirmation "Do you want to install them ?"
        if answer_for_confirmation ; then
            softwareupdate -ia
        fi

        if answer_for_confirmation "Do you want to restart ?"; then
            restart
        fi
    else
        log_warn "No available updates"
    fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
xcode_installed() {
    [ -d "/Applications/Xcode.app" ]
}

xcode_install() {
    # If necessary, prompt user to install `Xcode`.
    if ! is_xcode_installed; then
        log_exit "1" "Xcode is not installed.\nGo to App Store and Install it."
    fi
}

xcode_install_cli () {
    xcode-select --install &> /dev/null
    log_exit "$?" "Xcode Command Line Tools"
}

xcode_cli_installed () {
    xcode-select --print-path
}

xcode_accept_license () {
    # Automatically agree to the terms of the `Xcode` license.
    # https://github.com/alrra/dotfiles/issues/10
    sudo xcodebuild -license accept &> /dev/null
    log_exit "$?" "Xcode Command Line Tools"
}

xcode_set_developer_directory () {
    # Point the `xcode-select` developer directory to
    # the appropriate directory from within `Xcode.app`.
    # https://github.com/alrra/dotfiles/issues/13
    # https://stackoverflow.com/questions/17980759/xcode-select-active-developer-directory-error/17980786#17980786
    DEVELOPER_DIR="/Applications/Xcode.app/Contents/Developer"
    sudo xcode-select -switch "${DEVELOPER_DIR}" &> /dev/null
    log_exit "$?" "Xcode Command Line Tools"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #

bootstrap () {
    log_header "Boostrap OSX"
    xcode_install
    xcode_install_cli
    xcode_accept_license
    xcode_set_developer_directory
}

bootstrap
