# screen
if [[ ${TTY} = /dev/tty1 ]]; then
  # start X
  echo "Start X..."
  exec startx
else
  echo $STY
  # lunch screen
  if [ "$STY" = "" ]; then
    sessionName=`date +"%m%d-%H%M%S"`
    screen -S ${sessionName} -c ${SCREENRC}
  else
    # keychain
#    [ -e `which keychain` ] && keychain --nogui id_rsa
    [ -f $HOME/.keychain/$HOSTNAME-sh ] && \
        . $HOME/.keychain/$HOSTNAME-sh
    [ -f $HOME/.keychain/$HOSTNAME-sh-gpg ] && \
        . $HOME/.keychain/$HOSTNAME-sh-gpg
  fi
fi
