#!/bin/zsh

CONFIG=~/gitws/config
if ! [ -e $CONFIG -a -e `which git` ]; then
  echo "git clone first!"
  exit 1
fi
HOSTNAME=`hostname -s`
EMACSNAME=$CONFIG/.emacs.customized/.emacs.$HOSTNAME

if [ -e $EMACSNAME ]; then
    ln -s $EMACSNAME ~/.emacs
else
    ! [ -e ~/.emacs ] && ln -s $CONFIG/.emacs ~/.emacs
fi

! [ -e ~/.emacs.d ] && ln -s $CONFIG/.emacs.d ~/.emacs.d
! [ -e ~/.emacs.d/elisp ] && mkdir ~/.emacs.d/elisp

if [ -e ~/.emacs.d/elisp ]; then
  pushd
  cd ~/.emacs.d/elisp/
  ! [ -e git-emacs ] && git clone https://github.com/tsgates/git-emacs.git
  popd
fi
