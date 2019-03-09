# set hostname
if [[ -z $HOSTNAME || $HOSTNAME = "localhost" ]]; then
   HOSTNAME=`hostname`
   HOSTNAME=${HOSTNAME%%.*}
   export HOSTNAME
fi

[ -e ~/.zsh/config.zsh        ] && . ~/.zsh/config.zsh
[ -e ~/.zsh/path.zsh          ] && . ~/.zsh/path.zsh

# customize
[ -e ~/.zsh/machine.zsh ] && . ~/.zsh/machine.zsh

[ -e ~/.zsh/prompt.zsh        ] && . ~/.zsh/prompt.zsh
[ -e ~/.zsh/abbreviations.zsh ] && . ~/.zsh/abbreviations.zsh
[ -e ~/.zsh/hash.zsh          ] && . ~/.zsh/hash.zsh
[ -e ~/.zsh/screen.zsh        ] && . ~/.zsh/screen.zsh
[ -e ~/.zsh/aliases.zsh       ] && . ~/.zsh/aliases.zsh
[ -e ~/.zsh/aliassufix.zsh    ] && . ~/.zsh/aliassufix.zsh
[ -e ~/.zsh/globalaliases.zsh ] && . ~/.zsh/globalaliases.zsh
[ -e ~/.zsh/completion.zsh    ] && . ~/.zsh/completion.zsh

# ccache
[ -f ~/.ccacherc        ] && . ~/.ccacherc
