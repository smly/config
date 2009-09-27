#########################
######################### ZSH CONFIG

### Pager
if which less >/dev/null; then
  PAGER=less
  export LESS_TERMCAP_mb=$'\E[01;31m'
  export LESS_TERMCAP_md=$'\E[01;31m'
  export LESS_TERMCAP_me=$'\E[0m'
  export LESS_TERMCAP_se=$'\E[0m'
  export LESS_TERMCAP_so=$'\E[01;44;33m'
  export LESS_TERMCAP_ue=$'\E[0m'
  export LESS_TERMCAP_us=$'\E[01;32m'
  #LESSOPEN='| /usr/bin/lesspipe %s'
  #LESSCLOSE='/usr/bin/lesspipe %s %S'
else
  PAGER=more
fi

export PAGER

#########################
#########################

#export JAVA_HOME=/usr/java/jdk1.6.0_11
export HOME=/home/$USER

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export PATH
PATH=$PATH:$HOME/.cabal/bin          # haskell-cabal
#PATH=$PATH:$HOME/.gem/ruby/1.8/bin   # ruby-gems
PATH=$PATH:$HOME/.gem/ruby/1.9.1/bin
PATH=$PATH:/usr/bin/perlbin/vendor   # perl
PATH=$PATH:$JAVA_HOME/bin            # java
PATH=$PATH:$HOME/.zsh/utils          # zsh scripts
PATH=$PATH:$HOME/bin                 # user bin
PATH=$PATH:/usr/local/texlive/p2008/bin/i686-pc-linux-gnu  # texlive
#PATH=/usr/local/teTeX/bin:$PATH

#export HADOOP=$HOME/intern/hatenaintern2/smly/hadoop-0.18.0
#export TEXINPUTS=$HOME/.tex.d/
export CLASSPATH=$CLASSPATH:/home/smly/gitws/naist-exercises/dicision_tree/weka-3-6-1/weka.jar
export MANPATH=$MANPATH:$HOME/man:/usr/local/texlive/2008/texmf/doc/man
export EDITOR=emacs

export DISPLAY=:0.0

### locale
export LANGUAGE="ja"
export LC_ALL="ja_JP.UTF-8"
export LANG="ja"

#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/pgsql/lib

#########################
######################### EXTRA

## replace-string
autoload -U replace-string
zle -N replace-string
bindkey "^Xr" replace-string

### tetris
autoload -U tetris
zle -N tetris

### zftp
autoload -U zfinit t
zfinit

### zed
autoload zed # save: ^x ^w, cancel: ^c
setopt noflowcontrol # ignore flow control such as -- ^s ^q

### predict-on
autoload -U predict-on
zle -N predict-on
zle -N predict-off
bindkey '^xp' predict-on
bindkey '^x^p' predict-off
#zstyle ':predict' toggle true
zstyle ':predict' verbose true

#########################
######################### HISTORY SETTINGS

HISTFILE=~/.histfile
HISTSIZE=30000 # on memory
SAVEHIST=300000

setopt share_history      # all zsh sessions share the same history files
setopt hist_ignore_dups   # ignore same commands run twice
setopt extended_history   # puts timestamps
setopt inc_append_history # write after each command
setopt hist_ignore_space  # ignore commands that have a leading space
setopt append_history     # dont overwrite history
setopt hist_verify        # when using !, confirm first

if [ ${UID} = 0 ]; then
    unset HISTFILE        # for root
    SAVEHIST=0
fi

# historical backward/forward search
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

bindkey "^w" vi-backward-kill-word

#########################
######################### OPTIONS

setopt auto_cd           # auto change directory
setopt auto_pushd        # auto directory pushd that you can get dirs list by cd -[tab]
setopt pushd_ignore_dups

setopt correct           # command correct edition before each complietion attempt
setopt list_packed       # compacked complete list display
setopt nolistbeep        # no beep sound when complete list displayed

setopt nobeep            # nobeep
setopt nohistbeep        # no hintbeep

setopt complete_aliases  # aliased ls needs if file/dir completions work

#########################
#########################

# completion
fpath=(~/.zsh/completion $fpath)
autoload -U ~/.zsh/completion/*(:t)

# functions
fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)
[[ -f ~/.zsh/functions/functions ]] && . ~/.zsh/functions/functions

# ls color
case "${OSTYPE}" in
freebsd*|darwin*)
  alias ls="ls -G -w"
  ;;
linux*)
  alias ls="ls --color"
  ;;
esac

# color
autoload colors
colors

### terminal configuration
unset LSCOLORS
case "${TERM}" in
    xterm)
        export TERM=xterm-color
        ;;
    kterm)
        export TERM=kterm-coor
        # set BackSpace control character
        stty erase ^H
        ;;
esac
