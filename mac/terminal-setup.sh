#   _                      _             _ 
#  | |_ ___ _ __ _ __ ___ (_)_ __   __ _| |
#  | __/ _ \ '__| '_ ` _ \| | '_ \ / _` | |
#  | ||  __/ |  | | | | | | | | | | (_| | |
#   \__\___|_|  |_| |_| |_|_|_| |_|\__,_|_|
#          ___  ___| |_ _   _ _ __         
#         / __|/ _ \ __| | | | '_ \        
#         \__ \  __/ |_| |_| | |_) |       
#         |___/\___|\__|\__,_| .__/        
#                            |_|           

echo "Setting up Terminal...\n\n"

####
## Setup SSH Key
####
if ! [[ -f "$HOME/.ssh/id_rsa" ]]; then
  echo "Setting up SSH keys..."
  ssh-keygen -o -a 100 -t ed25519 -f "$HOME/.ssh/id_rsa" -C "$(whoami)@$(hostname)" -N ""
  SSH_CREATED=true
fi


####
## Install Prezto
####
if ! [[ -d "$HOME/.zprezto" ]]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"
fi


####
## Install Zplug
####
if ! [[ $(command -v zplug) ]]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi


####
## Install oh-my-tmux
####
if ! [[ -d "$HOME/.tmux/plugins" ]]; then
  echo "Creating tmux plugin folder..."
  mkdir -p "$HOME/.tmux/plugins"
fi

if ! [[ -d "HOME/.tmux/plugins/tpm" ]]; then
  echo "Installing tpm..."
  git clone --depth=1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
  echo "Updating tpm..."
  cd "$HOME/.tmux/plugins/tpm" && git pull && cd $RUN_DIR
fi


####
## Configure Git
####
echo "Configuring Git..."
git config --global user.name "Jon West"
git config --global user.email "jon@jw.gs"
git config --global user.editor "nvim"
git config --global pull.rebase false
git config --global init.defaultBranch "main"


####
## Install zsh plugins
####
if ! [ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
  echo "Installing zsh-autosuggestions..."
  git clone "https://github.com/zsh-users/zsh-autosuggestions" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions";
fi

if ! [ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
  echo "Installing zsh-syntax-highlighting..."
  git clone "https://github.com/zsh-users/zsh-syntax-highlighting.git" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting";
fi


####
## Install rclone
####
if ! [[ $(command -v rclone) ]]; then
  echo "Installing rclone..."
  curl https://rclone.org/install.sh | sudo bash
fi
