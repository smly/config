#!/bin/bash

[ ! -e ~/.zshrc ] && ln -s ~/gitws/config/.zshrc ~/.zshrc
[ ! -e ~/.zsh   ] && ln -s ~/gitws/config/.zsh ~/.zsh

if [ ! -e ~/.z ]; then
  mkdir $HOME/.z
  pushd
  cd /tmp
  git clone https://github.com/rupa/z.git
  cp z/z.sh ~/.zsh/functions/
  rm -rf /tmp/z
  popd
fi
 
