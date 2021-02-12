#   _   _     _       _    _  __ _                           
#  | |_| |__ (_)_ __ | | _(_)/ _(_) ___                      
#  | __| '_ \| | '_ \| |/ / | |_| |/ __|                     
#  | |_| | | | | | | |   <| |  _| | (__                      
#   \__|_| |_|_|_| |_|_|\_\_|_| |_|\___|_     _ _            
#   _ __  _ __ ___ _ __ ___  __ _ _   _(_)___(_) |_ ___  ___ 
#  | '_ \| '__/ _ \ '__/ _ \/ _` | | | | / __| | __/ _ \/ __|
#  | |_) | | |  __/ | |  __/ (_| | |_| | \__ \ | ||  __/\__ \
#  | .__/|_|  \___|_|  \___|\__, |\__,_|_|___/_|\__\___||___/
#  |_|                         |_|                           

export THINKIFIC_NODE_VERSION="v12.18.3"

echo "Checking for nvm..."
if ! [[ $(command -v nvm) ]]; then 
  echo "Installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

if ! [[ -f "$HOME/.npmrc" ]]; then
  echo "ERROR:  ${HOME}/.npmrc file not found, cannot continue!"
  echo "\t\t See https://thinkific.atlassian.net/wiki/spaces/ENG/pages/150995051/Setup+Gambier"
  exit 1
fi

echo "Checking node version..."
if ! [[ $(node -v) == $THINKIFIC_NODE_VERSION ]]; then
  echo "Installing node version ${THINKIFIC_NODE_VERSION}..."
  nvm install $THINKIFIC_NODE_VERSION &&

  echo "Setting ${THINKIFIC_NODE_VERSION} as default node version..."
  nvm use $THINKIFIC_NODE_VERSION

  if ! [[ $(node -v) == $THINKIFIC_NODE_VERSION ]]; then
    if [[ -f "$HOME/.zshrc" ]]; then source "$HOME/.zshrc"; else source "$HOME/.bashrc"; fi
  fi
fi


####
## Gambier
####
if ! [[ $(npm list -g | grep gambier) ]]; then
  echo "Installing Gambier..."
else
  echo "Updating Gambier..."
fi

npm install -g @thinkific/gambier

echo "Configuring Gambier..."
if [[ $(command -v gambier) ]]; then
  gambier configure
else
  echo "ERROR:  Gambier not installed, cannot continue!"
  exit 1
fi
