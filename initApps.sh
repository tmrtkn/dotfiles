#!/bin/bash

SCRIPT=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT")

ensure_installed() {
  local installed_app=$1
  echo "Ensure that '${installed_app}' is installed"
  # local return_value=`$(installed_app)`
  ${installed_app[@]}
  # git --version 2>&1 >/dev/null # improvement by tripleee
  IS_AVAILABLE=$?
  # echo "$GIT_IS_AVAILABLE"
  if [ $IS_AVAILABLE -ne 0 ]; then 
    echo "It is not installed!" 1>&2
    # echo "It is installed"
    exit 1
  fi;
}


ensure_git() {
  ensure_installed "git --version 2>&1 >/dev/null"
}
ensure_make() {
  ensure_installed "make --version 2>&1 >/dev/null"
}
ensure_aclocal() {
  ensure_installed "aclocal --version 2>&1 >/dev/null"
}

install_fzf() {
  echo "Installing fzf"
  ensure_git

  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install

  # git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf ~/.fzf/install
}

install_tmux() {
  echo "Installing tmux"
  ensure_git
  ensure_make
  ensure_aclocal
  

  TMUX_DIR=~/work/tmux
  # git clone https://github.com/tmux/tmux.git $TMUX_DIR
  cd $TMUX_DIR
  sh autogen.sh
  ./configure && make
  sudo make install
}

# Install Fuzzy finder
install_fzf
# Install the newest tmux from the git repo
install_tmux
# TODO: Install the following apps
# Latest neovim from the Repo?


exit 0
