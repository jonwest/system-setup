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

####
## Avoid interrupting script to ask for administrator password
####
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


####
## Update System
####
sudo apt update && sudo apt full-upgrade -yq


####
## Install System Utilities
####
sudo apt install -yq \
  build-essential \
  curl \
  file \
  git \
  zsh \
  p7zip-full \
  unzip \
  neovim \
  tmux \
  apt-transport-https \
  ca-certificates \
  gnupg-agent \
  software-properties-common \
  gnome-tweak-tool \
  node \
  yarn


####
## Setup Terminal
####
include "${RUN_DIR}/mac/terminal-setup.sh"

####
## Install Desktop Software
####
if [[ $(command -v snap) ]]; then
  sudo snap install slack --classic
  sudo snap install spotify --classic
  sudo snap install sublime-text --classic
  sudo snap install code --classic
fi


####
## Install Docker
####
if ! [[ $(command -v docker) ]]; then
  # Check for, or install GPG key
  [[ $(sudo apt-key fingerprint 0EBFCD88) ]] || curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

  # Add repo
  if ! [[ $(grep -q 'download.docker.com' /etc/apt/sources.list) ]]; then
    sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"
  fi

  # Install Docker
  sudo apt update && sudo apt install -yq docker-ce docker-ce-cli containerd.io
fi


####
## Install Albert
####
if ! [[ $(command -v albert) ]]; then
  echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_20.04/ /' | sudo tee /etc/apt/sources.list.d/home:manuelschneid3r.list
  curl -fsSL https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_20.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_manuelschneid3r.gpg > /dev/null
  sudo apt update && sudo apt install -yq albert
fi


####
## Fonts
####
if ! [[ (font-installed) ]]; then
  [[ -d "$HOME/.fonts" ]] || mkdir "$HOME/.fonts"

  if ! [[ -d "$HOME/.fonts/VictorMono" ]]; then
    mkdir "$HOME/.fonts/VictorMono" && cd "$HOME/.fonts/VictorMono"
    wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/VictorMono.zip"
    unzip VictorMono.zip
    find . -name '*Windows Compatible.ttf' -delete
    find . -name '*Mono.ttf' -delete
    rm VictorMono.zip
    cd $RUN_DIR
  fi

  # Set Monospace Font for the System to VictorMono:
  if ! [[ $(gsettings get org.gnome.desktop.interface monospace-font-name | grep 'VictorMono Nerd Font Semi-Bold 13') ]]; then
    gsettings set org.gnome.desktop.interface monospace-font-name 'VictorMono Nerd Font Semi-Bold 13'
  fi
fi


####
## Set Shortcuts
####
# Switch window switching shortcut to allow Alt-` for terminal
gsettings set org.gnome.desktop.wm.keybindings switch-group "['<Alt><Super>grave']"
gsettings set org.gnome.desktop.wm.keybindings switch-group-backward "['<Shift><Alt><Super>grave']"

# Set drop-down terminal shortcut:
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom0 binding "<Alt>grave"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom0 command "tilix --quake"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom0 name "Tilix"

####
## Set Keyboard Preferences
####
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 15
gsettings set org.gnome.desktop.peripherals.keyboard delay 200


####
## Set Nemo Preferences
####

# Default List View
gsettings set org.nemo.preferences default-folder-viewer "list-view"