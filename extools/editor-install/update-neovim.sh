#! /usr/bin/env bash

#================================================================================
# File Name    : extools/plugin-in-up/update-neovim.sh
# Author       : AlanDing
# Created Time : Sat 25 May 2019 08:52:21 PM CST
# Description  : 
#================================================================================

nvim --version

[ -d /opt/vim ] || mkdir -p /opt/vim


cd /tmp && sudo curl -fSLO \
  https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz \
  && tar -zxvf nvim-linux64.tar.gz

function build_install() {
  if [ -e /opt/vim/nvim-linux64-old ]; then
    sudo rm -rf /opt/vim/nvim-linux64-old
  fi
  if [ -e /opt/vim/nvim-linux64 ]; then
    sudo mv -i /opt/vim/nvim-linux64 /opt/vim/nvim-linux64-old
  fi
}

if [ -e /tmp/nvim-linux64 ]; then
  build_install && \
  cp /tmp/nvim-linux64 /opt/vim/
  nvim --version
fi

