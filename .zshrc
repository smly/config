
# set HOSTNAME
[ -z "$HOSTNAME" ] && HOSTNAME=`uname -n`
if [[ "$HOSTNAME" = "sage" ]]; then
    SCREENRC="$HOME/.screenrc.sage" # green, ^]^]
    [[ -f ~/.localrc ]] && . ~/.localrc
elif [[ "$HOSTNAME" = "hofmann" ]]; then
    SCREENRC="$HOME/.screenrc.hofmann" # red, ^t^t
else
    SCREENRC="$HOME/.screenrc.clserv" # blue, ^v^v
fi

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

if [[ $(tty) = /dev/tty1 ]]; then
  # start X
  if [[ -z "$DISPLAY" ]]; then
    startx
    logout
  fi
else
  echo $STY
  # lunch screen
  if [ "$STY" = "" ]; then
    screen -c $SCREENRC -R
  else
    # keychain
      keychain --nogui id_rsa
      [ -f $HOME/.keychain/$HOSTNAME-sh ] && \
          . $HOME/.keychain/$HOSTNAME-sh
      [ -f $HOME/.keychain/$HOSTNAME-sh-gpg ] && \
          . $HOME/.keychain/$HOSTNAME-sh-gpg
  fi
fi

# dircolors
#eval `dircolors ~/.dircolors -b`

# $TERM
# urxvt: rxvt-256color
# screen: xterm-256color
