# -*- shell-script -*-
SCREENRC=~/.screen/default
alias tmux="TERM=screen-256color-bce tmux"

case $HOSTNAME in
    resona)
        export XDG_CONFIG_HOME=~/.config
        export PATH=$HOME/anaconda3/bin:$PATH
        export PATH=$HOME/local/bin:/usr/local/cuda/bin:$PATH
        export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

        alias vim=nvim
        alias emacs=nvim

        export LANGUAGE="ja"
        export LC_ALL="ja_JP.UTF-8"
        export LANG="ja"

        export IS_LOCAL=`dig gov.x6 | grep ns.gov.x6`
	;;
    merill)
        export PATH=$HOME/anaconda3/bin:$PATH
        export PATH=$HOME/local/bin:/usr/local/cuda/bin:$PATH
        export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

        alias vim=nvim

        export LANGUAGE="ja"
        export LC_ALL="ja_JP.UTF-8"
        export LANG="ja"

        export IS_LOCAL=`dig gov.x6 | grep ns.gov.x6`
	;;
    janequin)
        alias vim=nvim

        export LANGUAGE="ja"
        export LC_ALL="ja_JP.UTF-8"
        export LANG="ja"

        export IS_LOCAL=`dig gov.x6 | grep ns.gov.x6`
	;;
    dmitry)
        export PATH=$HOME/anaconda3/bin:$PATH
        export PATH=$HOME/local/bin:/usr/local/cuda/bin:$PATH
        export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

        alias vim=nvim

        export LANGUAGE="ja"
        export LC_ALL="ja_JP.UTF-8"
        export LANG="ja"
	;;
    sander)
        export IS_LOCAL=`drill gov.x6 | grep ns.gov.x6`
	;;
    ramstein)
        export IS_LOCAL=`dig gov.x6 | grep ns.gov.x6`
	;;
    x1)
        export PATH=$HOME/anaconda/bin:$PATH
        export IS_LOCAL=`dig gov.x6 | grep ns.gov.x6`

        alias vim=nvim
    ;;
esac
export SCREENRC
