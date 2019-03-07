# -*- shell-script -*-
SCREENRC=~/.screen/default
alias tmux="TERM=screen-256color-bce tmux"

case `hostname` in
    gpu*)
        export PATH=$PATH:/usr/local/cuda/bin
        ;;
    *.*.h)
        PATH=$HOME/local/bin:$PATH
        PATH=/usr/sbin:/sbin:$PATH
        export PATH
        ;;
esac
case $HOSTNAME in
    resona)
        export XDG_CONFIG_HOME=~/.config
        export PATH="/home/marzio/anaconda3/bin:$PATH"
        export PATH=$HOME/local/bin:/usr/local/cuda/bin:$PATH
        export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
        alias vim=nvim
        alias emacs=nvim  # ;-)
        export LANGUAGE="ja"
        export LC_ALL="ja_JP.UTF-8"
        export LANG="ja"
	;;
esac
export SCREENRC
