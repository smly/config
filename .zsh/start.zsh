# screen
if [[ ${tty} = /dev/tty1 ]]; then
  # start X
  if [[ -z "$DISPLAY" ]]; then
    startx
    logout
  fi
else
  echo $STY
  # lunch screen
  if [ "$STY" = "" ]; then
    screen
    exit 0
  else
    # keychain
#    [ -e `which keychain` ] && keychain --nogui id_rsa
    [ -f $HOME/.keychain/$HOSTNAME-sh ] && \
        . $HOME/.keychain/$HOSTNAME-sh
    [ -f $HOME/.keychain/$HOSTNAME-sh-gpg ] && \
        . $HOME/.keychain/$HOSTNAME-sh-gpg
  fi
fi
