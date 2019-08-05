#!/usr/bin/env bash


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

log_header "Setting Apps Preferences"

# --------------------------------------------------------------------------- #
#                               TRANSMISSION                                  #
# --------------------------------------------------------------------------- #

# Prompt user for removal of active transfers only when downloading
defaults write org.m0k.transmission CheckRemoveDownloading -bool true

# Prompt user for quit with active transfers only when downloading
defaults write org.m0k.transmission CheckQuitDownloading -bool true

# Use `~/Downloads/torrents` to store completed downloads
defaults write org.m0k.transmission DownloadLocationConstant -bool true
defaults write org.m0k.transmission DownloadFolder -string "${HOME}/Downloads/Torrents"

# Don’t prompt for confirmation before downloading
defaults write org.m0k.transmission DownloadAsk -bool false
defaults write org.m0k.transmission MagnetOpenAsk -bool false

# Trash original torrent files
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

# Hide the donate message
defaults write org.m0k.transmission WarningDonate -bool false

# Hide the legal disclaimer
defaults write org.m0k.transmission WarningLegal -bool false

# IP block list.
# Source: https://giuliomac.wordpress.com/2014/02/19/best-blocklist-for-transmission/
defaults write org.m0k.transmission BlocklistNew -bool true
defaults write org.m0k.transmission BlocklistURL -string "http://john.bitsurge.net/public/biglist.p2p.gz"
defaults write org.m0k.transmission BlocklistAutoUpdate -bool true

# --------------------------------------------------------------------------- #

killall "Transmission" &> /dev/null

# --------------------------------------------------------------------------- #

log_info "✨  Setting Apps Preferences Success"
