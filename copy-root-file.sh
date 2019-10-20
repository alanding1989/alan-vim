#! /usr/bin/env bash


# File Name    : linux/alan-home/copy.sh
# Author       : AlanDing
# Created Time : Sun 20 Oct 2019 08:57:25 PM CST
# Description  : 

declare files=(
.agignore
.bash_profile
.bashrc
.cgdb
.conda
.condarc
.config
.gitconfig
.globalrc
.gradle
.ideavimrc
.ipython
.jupyter
.m2
.npmrc
.nvidia-settings-rc
.oh-my-zsh
.pip
.ruby-version
.rustup
.sbt
.shellcheckrc
software
.tmux
.tmux.conf
user-dirs.dirs
user-dirs.locale
.warprc
.xinputrc
.yarnrc
.zsh_history
.zshrc
)

for file in ${files[@]}; do
  cp -rf ~/$file /mnt/fun+downloads/my-Dotfile/linux/alan-home
done
