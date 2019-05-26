#!/bin/bash

# Move to home directory
pushd $HOME

if [ $(uname) == "Darwin" ]; then
  # Is MacOS
  # Install zsh
  brew update
  brew install zsh

  # Install fzf
  brew install fzf

  # Install stern
  brew install stern

  # Install kubectx/kubens
  brew install kubectx

  # Install tools
  brew install fd bat bash git hexyl jq kubectx tidy-html5 php q stern tig tldr tmux vim python rbenv
  brew tap wagoodman/dive
  brew install dive
  brew tap burntsushi/ripgrep https://github.com/BurntSushi/ripgrep.git
  brew install ripgrep-bin
  brew install yarn --ignore-dependencies
  brew cask install java
  brew install plantuml

  # Install zplug
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

  # Install go lang
  GO_INSTALLER=go1.11.4.darwin-amd64.pkg
  curl -sL -O https://dl.google.com/go/${GO_INSTALLER}
  sudo installer -pkg ${GO_INSTALLER} -target /


  # Reload PATH environment
  eval `/usr/libexec/path_helper -s`
elif [ $(uname) = "Linux" -a $(cat /etc/lsb-release | head -1 | cut -d= -f2) = "Ubuntu" ]; then
  sudo apt install vim git zsh

  # Install nvm
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
fi

# Return to original directory
popd

# Install dotfiles
CURRENT_DIR=$(cd $(dirname $0) | pwd)
ln -s ${CURRENT_DIR}/.zshrc ${HOME}/.zshrc
ln -s ${CURRENT_DIR}/.zshenv ${HOME}/.zshenv
ln -s ${CURRENT_DIR}/.zsh.d ${HOME}/.zsh.d
