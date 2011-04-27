#!/bin/zsh
CONFIG=~/gitws/config
if ! [ -e $CONFIG -a -e `which git` ]; then
  echo "git clone first!"
  exit 1
fi

! [ -e ~/.emacs ] && ln -s $CONFIG/.emacs ~/.emacs
! [ -e ~/.emacs.d ] && ln -s $CONFIG/.emacs.d ~/.emacs.d
! [ -e ~/.emacs.d/elisp ] && mkdir ~/.emacs.d/elisp

if [ -e ~/.emacs.d/elisp ]; then
  pushd
  cd ~/.emacs.d/elisp/
  ! [ -e git-emacs ] && git clone https://github.com/tsgates/git-emacs.git
  popd
fi
