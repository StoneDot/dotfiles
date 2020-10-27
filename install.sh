#!/bin/bash

# Move to home directory
pushd $HOME

if [ $(uname) == "Darwin" ]; then
  # Is MacOS
  # Install zsh fzf, stern, kubectx/kubens, renger
  brew update
  brew install zsh fzf stern kubectx ranger

  # Install tools
  brew install fd bat bash git hexyl jq kubectx tidy-html5 php q stern tig tldr tmux vim python rbenv
  brew tap wagoodman/dive
  brew install dive
  brew tap burntsushi/ripgrep https://github.com/BurntSushi/ripgrep.git
  brew install ripgrep-bin
  brew install yarn --ignore-dependencies
  brew cask install java
  brew install plantuml

  # Install go lang
  GO_INSTALLER=go1.12.7.darwin-amd64.pkg
  curl -sL -O https://dl.google.com/go/${GO_INSTALLER}
  sudo installer -pkg ${GO_INSTALLER} -target /


  # Reload PATH environment
  eval `/usr/libexec/path_helper -s`
elif [ $(uname) = "Linux" -a $(cat /etc/lsb-release | head -1 | cut -d= -f2) = "Ubuntu" ]; then
  sudo apt install neovim git zsh curl tmux build-essential rbenv virtualenv openjdk-15-dbg openjdk-15-doc openjdk-15-jdk openjdk-15-jre fd-find bat hexyl jq ripgrep tidy exa powerline

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
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

  # Install go lang
  curl -Lo- https://golang.org/dl/go1.15.3.linux-amd64.tar.gz | sudo tar -C /usr/local -xz
  mkdir -p ${HOME}/workspace/go
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
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

# Install vim extensions
vim +PluginInstall +qall
