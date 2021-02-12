#                 _                   
#   ___ _   _ ___| |_ ___ _ __ ___    
#  / __| | | / __| __/ _ \ '_ ` _ \   
#  \__ \ |_| \__ \ ||  __/ | | | | |  
#  |___/\__, |___/\__\___|_| |_| |_|  
#       |___/___  ___| |_ _   _ _ __  
#           / __|/ _ \ __| | | | '_ \ 
#           \__ \  __/ |_| |_| | |_) |
#           |___/\___|\__|\__,_| .__/ 
#                              |_|    

export RUN_DIR=$(pwd)

include() {
    [[ -f "$1" ]] && source "$1"
}


# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'


####
## Avoid interrupting script to ask for administrator password
####
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


####
## Setup Homebrew
####
if ! [[ -x "$(command -v brew)" ]]; then
  echo "Installing Homebrew..."
  /usr/bin/ruby -e \
  "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


####
## Setup folder structure
####
echo "Setting up folder structure..."
[[ -d "$HOME/Work" ]] || mkdir "$HOME/Work"
[[ -d "$HOME/Customization" ]] || mkdir "$HOME/Customization"


####
## Setup terminal and system applications
####
include "$(pwd)/mac/terminal-setup.sh"


####
## Setup dotfiles
####
include "$(pwd)/mac/dotfiles-setup.sh"


####
## Install applications via Homebrew
####
if ! [ -x "$(brew bundle --file=$(pwd)/mac/Brewfile check)" ]; then brew bundle --file=$(pwd)/mac/Brewfile && brew cleanup; fi


####
## Set up the dock
####
include "$(pwd)/mac/dock-cleanup.sh"
include "$(pwd)/mac/dock-preferences.sh"


####
## Device Preferences
####
include "$(pwd)/mac/finder-preferences.sh"
include "$(pwd)/mac/external-device-preferences.sh"
include "$(pwd)/mac/external-device-preferences.sh"
include "$(pwd)/mac/input-preferences.sh"


####
## Thinkific Setup
####
include "$(pwd)/thinkific/thinkific-prerequisites.sh"
if ! [ -x "$(brew bundle --file=$(pwd)/thinkific/Brewfile check)" ]; then brew bundle --file=$(pwd)/thinkific/Brewfile && brew cleanup; fi
