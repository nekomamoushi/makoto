#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../lib/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_bashrc_local() {

    declare -r BASHRC_PATH="$HOME/.bashrc.local"
    declare NVM_CONFIG="
export NVM_DIR=\"\${HOME}/.nvm\"
[ -s \"/usr/local/opt/nvm/nvm.sh\" ] && . \"/usr/local/opt/nvm/nvm.sh\"
[ -s \"/usr/local/opt/nvm/etc/bash_completion\" ] && . \"/usr/local/opt/nvm/etc/bash_completion\"
"
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    touch ${BASHRC_PATH}
    printf "%s\n" "${NVM_CONFIG}" >> "${BASHRC_PATH}"
}

create_directories() {
    declare -a DIRECTORIES=(
        "{$HOME}/Downloads/torrents"
    )

    for i in "${DIRECTORIES[@]}"; do
        mkdir -p "$i"
    done
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
    log_header "Manage Local Files"
    create_bashrc_local
    create_directories
}

main
