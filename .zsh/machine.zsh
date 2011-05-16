# -*- shell-script -*-
SCREENRC=~/.screen/default
case $HOSTNAME in
    sage)
        ;;
    shapiro)
        export HADOOP_HOME=/usr/local/hadoop
        PATH=~/.gem/ruby/1.8/bin:$HADOOP_HOME/bin:$PATH
        PATH=/usr/local/share/python:$PATH
        export PATH
        SCREENRC=~/.screen/$HOSTNAME
        ;;
    moss)
        export PATH=$PATH:/usr/local/Cellar/python/2.6.6/bin
        ;;
    hofmann)
        ;;
    chung)
        ;;
    sussman)
        ;;
    pine2|pine3|pine4|pine5|pine6)
        ;;
    cacao|parsley|papaya|tomato|carrot|radish|pepper|bean|cactus|chasen)
        ;;
    apple)
        ;;
esac
export SCREENRC
