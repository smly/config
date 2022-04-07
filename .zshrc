# Enable Powerlevel10k instant prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

eval "$(sheldon source)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# TODO

# Hostname
if [[ -z $HOSTNAME || $HOSTNAME = "localhost" ]]; then
   HOSTNAME=`hostname`
   HOSTNAME=${HOSTNAME%%.*}
   export HOSTNAME
fi

[[ $HOSTNAME = "aegis" ]] && source ~/.zsh/machines/aegis.zsh
