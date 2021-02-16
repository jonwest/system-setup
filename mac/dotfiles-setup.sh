#       _       _    __ _ _
#    __| | ___ | |_ / _(_) | ___  ___
#   / _` |/ _ \| __| |_| | |/ _ \/ __|
#  | (_| | (_) | |_|  _| | |  __/\__ \
#   \__,_|\___/ \__|_| |_|_|\___||___/
#        ___  ___| |_ _   _ _ __
#       / __|/ _ \ __| | | | '_ \
#       \__ \  __/ |_| |_| | |_) |
#       |___/\___|\__|\__,_| .__/
#                          |_|

echo "Setting up dotfiles...\n\n"

####
## Clone dotfiles repo
####
if ! [[ -d "$HOME/Customization/dotfiles" ]]; then
  echo "Bringing in dotfiles..."
  git clone "https://github.com/jonwest/dotfiles" "$HOME/Customization/dotfiles"
fi


####
## Setup zshrc
####
if ! [[ -L "$HOME/.zshrc" ]]; then
  echo "Setting up zshrc..."
  rm -f "$HOME/.zshrc"
  ln -s "$HOME/Customization/dotfiles/zshrc/zshrc.zsh" "$HOME/.zshrc"
fi


####
## Neovim
####
[[ -d "$HOME/.config/nvim" ]] || mkdir -p "$HOME/.config/nvim"

if ! [ -L "$HOME/.config/nvim/init.vim" ]; then
  echo "Setting up neovim..."
  rm -f "$HOME/.config/nvim/init.vim" && ln -s "$HOME/Customization/dotfiles/neovim/neovim.init" "$HOME/.config/nvim/init.vim"
fi

if ! [ -d "$HOME/.local/share/nvim/site/autoload" ]; then
  echo "Installing VimPlug..."
  curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
fi

nvim -c "PlugInstall" -c "qa\!"


####
## Tmux
####
if ! [ -L "$HOME/.tmux.conf" ]; then
  echo "Setting up tmux..."
  rm -f "$HOME/.tmux.conf" && ln -s "$HOME/Customization/dotfiles/tmux/tmux.conf" "$HOME/.tmux.conf" &&\

  if ! [[ -f "$HOME/.tmux/plugins/tpm/bin/install_plugins" ]]; then
    echo "Installing tmux plugins..."
    exec $HOME/.tmux/plugins/tpm/bin/install_plugins;
  else
    echo "ERROR: tpm bin missing, cannot install tmux plugins!"
  fi
fi
