#!/usr/bin/env bash

# Ensure that the following actions are made relative to this file's path.
cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

./macos/bootstrap.sh

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

./manage_dotfiles.sh

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

./manage_local.sh

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

./macos/install/main.sh

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

./macos/preferences/main.sh

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


