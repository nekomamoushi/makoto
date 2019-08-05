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

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_directories() {
    declare -a DIRECTORIES=(
        "{$HOME}/Downloads/torrents"
    )

    for i in "${DIRECTORIES[@]}"; do
        mkdir -p "$i"
    done
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_ssh_key () {
    declare -a HOSTS=(
        "github.com"
        "gitlab.com"
    )
    local ssh_key_filename="${HOME}/.ssh/id_rsa"
    local ssh_public_key_filename="${HOME}/.ssh/id_rsa.pub"

    ssh_gen_key "${ssh_key_filename}"
    for host in "${HOSTS[@]}"; do
        ssh_add_config "${host}" "${ssh_public_key_filename}"
    done
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main () {
    log_header "Manage Local Files"

    create_directories
    create_bashrc_local
    create_ssh_key
}

main
