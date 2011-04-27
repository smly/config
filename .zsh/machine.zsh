# -*- shell-script -*-
SCREENRC=~/.screen/default
case $HOSTNAME in
    sage)
        ;;
    shapiro)
        export PATH=$PATH:~/.gem/ruby/1.8/bin
        SCREENRC=~/.screen/$HOSTNAME
        ;;
    moss)
        export PATH=$PATH:/usr/local/Cellar/python/2.6.6/bin/ 
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
