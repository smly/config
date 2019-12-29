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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/marzio/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/marzio/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/marzio/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/marzio/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

