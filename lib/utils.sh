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
