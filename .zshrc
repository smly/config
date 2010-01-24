# common settings
. ~/.zsh/config.zsh
. ~/.zsh/server.zsh # detect HOST_OS

# set HOSTNAME
[ -z "$HOSTNAME" ] && HOSTNAME=`uname -n`

# local settings
case $HOSTNAME in
    sage)
        SCREENRC="$HOME/.screen/sage" # green, ^]^]
        [[ -f ~/.zsh/local/sage.zsh ]] && . ~/.zsh/local/sage.zsh ;;
    hofmann)
        SCREENRC="$HOME/.scree/hofmann" # red, ^t^t
        [[ -f ~/.zsh/local/hofmann.zsh ]] && . ~/.zsh/local/hofmann.zsh ;;
    *)
        case $HOST_OS in
            "Ubuntu 9.04")
                ;;
            "Ubuntu 8.04")
                ;;
        esac ;;
esac

# load scripts
. ~/.zsh/prompt.zsh
. ~/.zsh/abbreviations.zsh
. ~/.zsh/hash.zsh
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
