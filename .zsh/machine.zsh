# -*- shell-script -*-
SCREENRC=~/.screen/default
case $HOSTNAME in
    sage)
        ;;
    shapiro)
        export HADOOP_HOME=/usr/local/hadoop
        export PATH=$PATH:~/.gem/ruby/1.8/bin:$HADOOP_HOME/bin
        SCREENRC=~/.screen/$HOSTNAME
        ;;
    moss|softbank*)
        export PATH=$PATH:~/.gem/ruby/1.8/bin:/usr/local/Cellar/python/2.6.6/bin
        SCREENRC=~/.screen/shapiro
        ;;
    hofmann)
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
