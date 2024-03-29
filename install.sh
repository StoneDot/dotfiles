#!/bin/bash

CURRENT_DIR=$(cd $(dirname $0) | pwd)

# Move to home directory
pushd $HOME

# Install dotfiles
ln -s ${CURRENT_DIR}/.zshrc ${HOME}/.zshrc
ln -s ${CURRENT_DIR}/.zshenv ${HOME}/.zshenv
ln -s ${CURRENT_DIR}/.zsh.d ${HOME}/.zsh.d
ln -s ${CURRENT_DIR}/.vimrc ${HOME}/.vimrc
ln -s ${CURRENT_DIR}/.tmux.conf ${HOME}/.tmux.conf
mkdir -p ${HOME}/.config/alacritty
ln -s ${CURRENT_DIR}/alacritty.xml ${HOME}/.config/alacritty/alacritty.yml

# Install neovim config
mkdir -p ${HOME}/.config/nvim/
ln -s ${CURRENT_DIR}/init.vim ${HOME}/.config/nvim/init.vim

# Install homebrew for Linux
which brwe &> /dev/null
if [ $? -ne 0 ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  brew update
fi

# Install common tools
brew install neovim git kubectx tidy-html5 stern tldr tmux

if [ $(uname) == "Darwin" ]; then
  # Install tools
  brew install fd jq bat bash hexyl zoxide php tig vim python rbenv expect
  brew tap wagoodman/dive
  brew install dive
  brew tap burntsushi/ripgrep https://github.com/BurntSushi/ripgrep.git
  brew install ripgrep-bin
  brew install yarn --ignore-dependencies
  brew cask install java
  brew install plantuml

  # Install go lang
  GO_INSTALLER=go1.17.5.darwin-arm64.pkg
  curl -sL -O https://dl.google.com/go/${GO_INSTALLER}
  sudo installer -pkg ${GO_INSTALLER} -target /


  # Reload PATH environment
  eval `/usr/libexec/path_helper -s`
elif [ $(uname) = "Linux" -a $(cat /etc/lsb-release | head -1 | cut -d= -f2) = "Ubuntu" ]; then
  sudo apt install git zsh curl tmux build-essential rbenv virtualenv fd-find bat hexyl jq ripgrep tidy exa powerline bc socat

  # Install rust env
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  source $HOME/.cargo/env
  rustup override set stable
  rustup update stable

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

# Install git-delta
cargo install git-delta

# Add configuration for git
git config --global user.email "goto.inct@gmail.com"
git config --global user.name "Hiroaki Goto"
git config --global core.autocrlf input
git config --global core.whitespace cr-at-eol
git config --global merge.conflictstyle diff3
git config --global core.pager delta
git config --global interactive.difffilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.line-numbers true
git config --global diff.colormoved default

# Install GHQ
go install github.com/x-motemen/ghq@latest

# Install zplugin
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

# Install vim extensions
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
