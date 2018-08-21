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
    robert)
        alias x="exec zsh"
        PATH=$PATH:~/.gem/ruby/1.9.1/bin
        export PATH
        SCREENRC=~/.screen/default
        ;;
    adamic)
        PATH=$PATH:~/.gem/ruby/1.9.1/bin
        export PATH
        export LC_ALL=en_US.UTF-8
        export LANGUAGE=en
        export LANG=en
        ;;
    edmonds)
        PATH=$PATH:~/.gem/ruby/1.9.1/bin
        PATH=$PATH:/opt/java/bin
        export PATH
        ;;
    resona)
        export XDG_CONFIG_HOME=~/.config
        export PATH="/home/marzio/anaconda3/bin:$PATH"
        export PATH=/usr/local/cuda/bin:$PATH
        export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
        alias vim=nvim

	export LANGUAGE="ja"
	export LC_ALL="ja_JP.UTF-8"
	export LANG="ja"
	;;
    shapiro)
        export HADOOP_HOME=/usr/local/hadoop
        PATH=~/.gem/ruby/1.8/bin:$HADOOP_HOME/bin:$PATH
        PATH=/usr/local/share/python:$PATH
        export PATH
        SCREENRC=~/.screen/$HOSTNAME
        ;;
    moss|softbank*)
#        export PATH=$PATH:~/.gem/ruby/1.8/bin:/usr/local/Cellar/python/2.6.6/bin
        PATH=$PATH:/usr/local/Cellar/ruby/1.9.2-p180/bin
        PATH=$PATH:/usr/local/Cellar/python/2.6.6/bin
        PATH=$PATH:/usr/local/Cellar/smlnj/110.72/libexec/bin
        export PATH
        SCREENRC=~/.screen/shapiro
        ;;
    hofmann)
        ;;
    dmitry)
        PATH=$PATH:$HOME/anaconda3/bin
        ;;
    chung)
        ;;
    sussman)
        ;;
    pine*)
        ;;
    cacao|parsley|papaya|tomato|carrot|radish|pepper|bean|cactus|chasen)
        ;;
    apple)
        ;;
esac
export SCREENRC
