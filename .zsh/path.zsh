# -*- shell-script -*-

case $HOSTNAME in
  moss)
    [[ -f ~/.zsh/path/moss.zsh ]] && . ~/.zsh/path/moss.zsh
    ;;
  *)
    ;;
esac
