#!/usr/bin/env bash

#=============#
# ANSI COLORS #
#=============#

RESET='\033[0m'
BOLD='\033[1m'
ITALIC='\033[3m'
UNDERLINE='\033[4m'

BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

SUCCESS_SYMBOL="✓"
ERROR_SYMBOL="✗"
WARNING_SYMBOL="⚠"
INFO_SYMBOL="i"
ARROW_SYMBOL="➜"
QUESTION_SYMBOL="?"
EXIT_SYMBOL="☠"

log () {
    printf "%s\n" "$1"
}

log_empty () {
    printf "\n"
}

log_info () {
    printf "    [ %b%s%b ] %s\n" "${WHITE}" "${INFO_SYMBOL}" "${RESET}" "$1"
}

log_header () {
    printf "• %b%s%b\n" "${BLUE}" "$1" "${RESET}"
    log_empty
}

log_question () {
    printf "    [ %b%s%b ] %s : " "${CYAN}" "${QUESTION_SYMBOL}" "${RESET}" "$1"
}

log_arrow () {
    log_empty
    printf "  %b%s %b%s%b\n" "${BLUE}" "${ARROW_SYMBOL}" "${italic}" "$1" "${RESET}"
    log_empty
}

log_wait () {
    printf "\r    [ %s ] %s" " " "$1"
}

log_success () {
    printf "\r    [ %b%s%b ] %s\n" "${GREEN}" "${SUCCESS_SYMBOL}" "${RESET}" "$1"
}

log_warn () {
    printf "    [ %b%s%b ] %s\n" "${YELLOW}" "${WARNING_SYMBOL}" "${RESET}" "$1"
}

log_error () {
    printf "\r    [ %b%s%b ] %s\n" "${RED}" "${ERROR_SYMBOL}" "${RESET}" "$1"
}

log_error_stream () {
    while read -r line; do
        printf "%s\n" "      ↳ ERROR: $line"
    done
}

log_result () {
    if [ "$1" = "0" ] ; then
        log_success "$2"
    else
        log_error "$2"
    fi
}

log_exit () {
    if [ "$1" = "0" ] ; then
        log_success "$2"
        return 0
    else
        printf "\n\n%b%s%b\n\n" "${RED}" "↳ EXIT: $2" "${reset}"
        exit 1
    fi
}

execute () {
    command="$1"
    message="${2:-$1}"
    tmp_file="$(mktemp /tmp/XXXXX)"

    exit_code=0
    pid_command=""

    log_wait "${message}"
    # Execute commands in background
    eval "${command}" &> /dev/null 2> "${tmp_file}" &
    pid_command=$!

    # Wait for the commands to no longer be executing
    # in the background, and then get their exit code.
    wait "${pid_command}" &> /dev/null
    exit_code=$?

    # Print output based on what happened.
    log_result "${exit_code}" "$MSG"

    if [ ${exit_code} -ne 0 ]; then
        log_error_stream < "${tmp_file}"
    fi

    rm -rf "${tmp_file}}"

    return ${exit_code}
}

empty () {
    if [[ -z "$1" ]]; then
        return 0
    fi
    return 1
}

not_empty() {
    if [[ -n "$1" ]]; then
        return 0
    fi
    return 1
}

has () {
    command -v "$1" &> /dev/null
}

ask () {
    log_question "$1"
    read -r
}

ask_for_confirmation () {
    log_question "$1 (y/n) "
    read -r -n 1
    printf "\n"
}

answer () {
    printf "%s" "${REPLY}"
}

answer_for_confirmation () {
    [[ "${REPLY}" =~ ^[Yy]$ ]] && return 0 || return 1
}

ask_for_sudo () {

    # Ask for the administrator password upfront.
    sudo -v &> /dev/null

    # Update existing `sudo` time stamp
    # until this script has finished.
    #
    # https://gist.github.com/cowboy/3118588
    while true; do
        sudo -n true
        sleep 60
        kill -0 "$$" || exit
    done &> /dev/null &
}

get_os () {
    OS_TYPE=$(uname -s)
    printf "%s" "${OS_TYPE}"
}

verify_os () {
    OS_TYPE=$(get_os)
    if [ "${OS_TYPE}" == "$1" ] ; then
        return 0
    else
        return 1
    fi
}

darwin () {
    if verify_os "Darwin" ; then
        return 0
    fi
    return 1
}

restart () {
    ask_for_confirmation "Do you want to restart"
    if ! answer_for_confirmation; then
        return 0
    fi
    sudo shutdown -r now &> /dev/null
}

brew_tap () {
    execute "brew tap $1"
}

brew_install () {
    if brew list "$1" &> /dev/null ; then
        log_warn "$1 is already installed"
        return 0
    fi
    execute "brew install $1"
}

cask_install () {
    if brew cask list "$1" &> /dev/null ; then
        log_warn "$1 is already installed"
        return 0
    fi
    execute "brew cask install $1"
}

download() {
    local url="$1"
    local output="$2"

    if has "curl" &> /dev/null; then

        curl -LsSo "$output" "$url"
        #     │││└─ write output to file
        #     ││└─ show error messages
        #     │└─ don't show the progress meter
        #     └─ follow redirects

        return $?

    elif has "wget" &> /dev/null; then

        wget -qO "$output" "$url" &> /dev/null
        #     │└─ write output to file
        #     └─ don't show output

        return $?
    fi

    return 1
}

symlink () {
    local source_path="$1"
    local target_path="$2"

    ln -s "${source_path}" "${target_path}" &> /dev/null
}

ssh_gen_key () {
    default_ssh_key_filename="${HOME}/.ssh/id_rsa"
    pub_rsa_file="${1:-$default_ssh_key_filename}"

    ask "Email: "
    email_address="$(answer)"

    ask "Passphrase: "
    passphrase="$(answer)"

    ssh-keygen -t rsa -b 4096 -C "${mail_address}" -f "${pub_rsa_file}" -N "${passphrase}"
    log_result $? "Generate SSH Key"
}

ssh_copy_public_key_to_clipboard () {
    ssh_public_key=$1

    if has "pbcopy" ; then
        pbcopy < "${ssh_public_key}"
        log_result $? "Copy to ClipboardS SH Public Key "
    else
        log_warn "Please Copy the public SSH key to clipboard"
    fi
}

ssh_add_config () {
    ssh_config_file="${HOME}/.ssh/config"

    touch "${ssh_config_file}"
    printf "%s\n" \
        "Host $1" \
        "  HostName $1"
        "  PreferredAuthentications publickey" \
        "  IdentityFile $2" >> "${ssh_config_file}"
    log_result $? "Add SSH Key to SSH config"
}
