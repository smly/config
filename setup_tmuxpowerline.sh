#!/bin/bash

cd $HOME/gitws/config
mkdir -p trunk
git clone https://gitub.com/erikw/tmux-powerline.git trunk/tmux-powerline
rm $HOME/gitws/config/trunk/tmux-powerline/themes/default.sh
ln -s $HOME/gitws/config/tmux-theme/default.sh $HOME/gitws/config/trunk/tmux-powerline/themes/default.sh
ln -s $HOME/gitws/config/.tmux.conf $HOME/.tmux.conf
ln -s $HOME/gitws/config/.tmux-powerlinerc $HOME/.tmux-powerlinerc
