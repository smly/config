# load scripts
. ~/.zsh/prompt.zsh
. ~/.zsh/config.zsh
. ~/.zsh/screen.zsh
. ~/.zsh/zleiab.zsh # abbreviations
. ~/.zsh/aliases.zsh
. ~/.zsh/aliassufix.zsh
. ~/.zsh/globalaliases.zsh
. ~/.zsh/completion.zsh

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc

# dircolors
# eval `dircolors ~/.dircolors -b`

#if [ $SHLVL = 1 ] || ! [ $TERM = "screen" ]; then
#  screen -R
#fi
if ! [ $TERM = "screen" ] && ! [ $TERM = "linux" ]; then
    screen -R
fi
