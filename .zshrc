# load scripts
. ~/.zsh/prompt.zsh
. ~/.zsh/abbreviations.zsh
. ~/.zsh/hash.zsh
. ~/.zsh/config.zsh
. ~/.zsh/screen.zsh
. ~/.zsh/aliases.zsh
. ~/.zsh/aliassufix.zsh
. ~/.zsh/globalaliases.zsh
. ~/.zsh/completion.zsh

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc
# dircolors
#eval `dircolors ~/.dircolors -b`

# $TERM
# urxvt: rxvt-256color
# screen: xterm-256color

if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
  startx
  logout
fi

if [[ $(tty) = /dev/tty1 ]]; then
  startx
  logout
fi

if [[ $(tty) != /dev/tty1 ]]; then
  echo $STY
  if [ "$STY" = "" ]; then
    screen -R
  fi
fi
