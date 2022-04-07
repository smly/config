#!/bin/bash

[ ! -e ~/.tmux/plugins/tpm ] && mkdir -p ~/.tmux/plugins/ && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
[ ! -e ~/.tmux.conf   ] && ln -s ~/gitws/config/.tmux.conf ~/.tmux.conf  # TODO: prefix+I

[ ! -e ~/.gitconfig ] && ln -s ~/gitws/config/.gitconfig ~/.gitconfig
[ ! -e ~/.gitconfig.work ] && ln -s ~/gitws/config/.gitconfig.work ~/.gitconfig.work

# [ ! -e ~/.zsh   ] && ln -s ~/gitws/config/.zsh ~/.zsh
# [ ! -e ~/.zshrc ] && ln -s ~/gitws/config/.zshrc ~/.zshrc

# [ ! -e ~/.config/nvim ] && ln -s ~/gitws/config/.config/nvim ~/.config/nvim
# [ ! -e ~/.Xdefaults   ] && ln -s ~/gitws/config/.Xdefaults ~/.Xdefaults
# [ ! -e ~/.Xresources  ] && ln -s ~/gitws/config/.Xresources ~/.Xresources
