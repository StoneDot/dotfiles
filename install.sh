#!/bin/bash

# Move to home directory
pushd $HOME

if [ $(uname) == "Darwin" ]; then
  # Is MacOS
  brew update
  brew install stern kubectx ranger

  # Install tools
  brew install fd bat bash git hexyl jq kubectx tidy-html5 php q stern tig tldr tmux vim python rbenv zoxide expect
  brew tap wagoodman/dive
  brew install dive
  brew tap burntsushi/ripgrep https://github.com/BurntSushi/ripgrep.git
  brew install ripgrep-bin
  brew install yarn --ignore-dependencies
  brew cask install java
  brew install plantuml

  # Install go lang
  GO_INSTALLER=go1.17.2.darwin-arm64.pkg
  curl -sL -O https://dl.google.com/go/${GO_INSTALLER}
  sudo installer -pkg ${GO_INSTALLER} -target /


  # Reload PATH environment
  eval `/usr/libexec/path_helper -s`
elif [ $(uname) = "Linux" -a $(cat /etc/lsb-release | head -1 | cut -d= -f2) = "Ubuntu" ]; then
  sudo apt install neovim git zsh curl tmux build-essential rbenv virtualenv fd-find bat hexyl jq ripgrep tidy exa powerline bc

  # For install alacritty
  sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  source $HOME/.cargo/env
  rustup override set stable
  rustup update stable
  git clone git@github.com:alacritty/alacritty.git
  pushd alacritty
  cargo build --release
  infocmp alacritty
  if [ $? = 1 ]; then
    sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
  fi
  sudo cp target/release/alacritty /usr/local/bin
  sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
  sudo desktop-file-install extra/linux/Alacritty.desktop
  sudo update-desktop-database
  sudo mkdir -p /usr/local/share/man/man1
  gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
  popd
  rm -rf alacritty

  session_type=$(loginctl show-session $(loginctl | grep $(whoami) | awk '{print $1}') -p Type | cut -d= -f2)
  if [ $session_type = X11 ]; then
    sudo apt install vim-gnome
  elif [ $session_type = wayland ]; then
    sudo apt install wl-clipboard
  fi

  # Install nvm
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

  # Install go lang
  curl -Lo- https://go.dev/dl/go1.19.5.linux-amd64.tar.gz | sudo tar -C /usr/local -xz
  mkdir -p ${HOME}/workspace/go

  # Install expect
  sudo apt-get install expect
fi

if [ $(uname) == "Linux" ]; then
  curl -sS https://webinstall.dev/zoxide | bash
fi
# Return to original directory
popd

# Install dotfiles
CURRENT_DIR=$(cd $(dirname $0) | pwd)
ln -s ${CURRENT_DIR}/.zshrc ${HOME}/.zshrc
ln -s ${CURRENT_DIR}/.zshenv ${HOME}/.zshenv
ln -s ${CURRENT_DIR}/.zsh.d ${HOME}/.zsh.d
ln -s ${CURRENT_DIR}/.vimrc ${HOME}/.vimrc
ln -s ${CURRENT_DIR}/.tmux.conf ${HOME}/.tmux.conf
mkdir -p ${HOME}/.config/alacritty
ln -s ${CURRENT_DIR}/alacritty.xml ${HOME}/.config/alacritty/alacritty.yml

# Install zplugin
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

# Install vim extensions
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
