# -*- shell-script -*-
SCREENRC=~/.screen/default

HOSTNAME=ritchie
case `hostname` in
    *.*.h)
        PATH=$HOME/local/bin:$PATH
        PATH=/usr/sbin:/sbin:$PATH
        export PATH
        ;;
esac
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
    moss|softbank*)
#        export PATH=$PATH:~/.gem/ruby/1.8/bin:/usr/local/Cellar/python/2.6.6/bin
        PATH=$PATH:/usr/local/Cellar/ruby/1.9.2-p180/bin
        PATH=$PATH:/usr/local/Cellar/python/2.6.6/bin
        PATH=$PATH:/usr/local/Cellar/smlnj/110.72/libexec/bin
        export PATH
        SCREENRC=~/.screen/shapiro
        ;;
    ritchie)
        alias termtter='ruby ~/gitws/github/termtter/bin/termtter'
        export PATH=$HOME/ws/android/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin:$PATH
        export ARCH=arm
        export SUBARCH=arm
        export CROSS_COMPILE=arm-eabi-

        export PATH=$HOME/.gem/ruby/1.9.1/bin:$PATH
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
