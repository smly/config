# load scripts
. ~/.zsh/prompt.zsh
. ~/.zsh/zleiab.zsh # abbreviations
. ~/.zsh/config.zsh
. ~/.zsh/screen.zsh
. ~/.zsh/aliases.zsh
. ~/.zsh/aliassufix.zsh
. ~/.zsh/globalaliases.zsh
. ~/.zsh/completion.zsh

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc
# dircolors
eval `dircolors ~/.dircolors -b`

echo $STY

if [ "$STY" = "" ]; then
    screen -R
fi
