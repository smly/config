#!/bin/bash

[ ! -e ~/.zshrc ] && ln -s ~/gitws/config/.zshrc ~/.zshrc
[ ! -e ~/.zsh   ] && ln -s ~/gitws/config/.zsh ~/.zsh
[ ! -e ~/.config/nvim ] && ln -s ~/gitws/config/.config/nvim ~/.config/nvim
[ ! -e ~/.tmux.conf   ] && ln -s ~/gitws/config/.tmux.conf ~/.tmux.conf
[ ! -e ~/.Xdefaults   ] && ln -s ~/gitws/config/.Xdefaults ~/.Xdefaults
[ ! -e ~/.Xresources  ] && ln -s ~/gitws/config/.Xresources ~/.Xresources
