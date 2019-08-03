#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

. "../lib/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

ask "Quel est votre passion"
log_info "Answer = $(answer)"

ask_for_confirmation "Etes vous une fougere"
answer_for_confirmation
log_result $? "Confirmation"

verify_os "Linux"
log_result $? "On Linux"

darwin
log_result $? "On OSX"

has "curl"
log_result $? "curl is installed"

has "noel"
log_result $? "noel is not installed"
