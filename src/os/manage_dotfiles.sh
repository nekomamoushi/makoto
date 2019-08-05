#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../lib/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

DOTFILES_DIRECTORY="${HOME}/.dotfiles"
DOTFILES_TARBALL_URL="https://github.com/nekomamoushi/dotfiles/tarball/master"

download_dotfiles() {

    log_arrow "Download and Extract Dotfiles"

    local dotfilesDir="${1-$DOTFILES_DIRECTORY}"
    local dotfilesUrl="${2-$DOTFILES_TARBALL_URL}"
    local tmpFile=""

    tmpFile="$(mktemp /tmp/XXXXX)"
    download "$DOTFILES_TARBALL_URL" "$tmpFile"
    log_result "$?" "Download dotfiles tarball"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    mkdir -p "$dotfilesDir"

    # Extract archive in the `dotfiles` directory.
    tar -zxf "$tmpFile" --strip-components 1 -C "$dotfilesDir"
    log_result "$?" "Extract dotfiles tarball"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    rm -rf "$tmpFile"
    log_result "$?" "Remove dotfiles tarball"

}

symlink_dotfiles () {
    log_arrow "Symlink Dotfiles"

    local dotfilesDir="${1-$DOTFILES_DIRECTORY}"
    declare -a FILES_TO_SYMLINK=(
        "etc/bash/bashrc"
        "etc/bash/inputrc"
        "etc/zsh/zshenv"
        "etc/zsh/zshrc"
        "etc/git/gitattributes"
        "etc/git/gitconfig"
        "etc/git/gitignore"
        "etc/vim/vimrc"
    )

    for file in "${FILES_TO_SYMLINK[@]}"; do
        target_filename="${HOME}/.$(basename "${file}")"
        source_filename="${dotfilesDir}/${file}"

        symlink "${source_filename}" "${target_filename}"
        log_result "$?" "Symlink: ${target_filename} -> ${source_filename}"
    done
}

main () {
    log_header "Manage Dotfiles"
    download_dotfiles
    symlink_dotfiles
}

main
