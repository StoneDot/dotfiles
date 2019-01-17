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

  # Install zplug
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

  # Install go lang
  GO_INSTALLER=go1.11.4.darwin-amd64.pkg
  curl -sL -O https://dl.google.com/go/${GO_INSTALLER}
  sudo installer -pkg ${GO_INSTALLER} -target /


  # Reload PATH environment
  eval `/usr/libexec/path_helper -s`
fi

# Return to original directory
popd

# Install dotfiles
CURRENT_DIR=$(cd $(dirname $0) | pwd)
ln -s ${CURRENT_DIR}/.zshrc ${HOME}/.zshrc
ln -s ${CURRENT_DIR}/.zshenv ${HOME}/.zshenv
ln -s ${CURRENT_DIR}/.zsh.d ${HOME}/.zsh.d
