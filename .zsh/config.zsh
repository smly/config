# -*- shell-script -*-

### pager
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

# etc
export EDITOR="emacs"
export DISPLAY=:0.0

### locale
export LANGUAGE="ja"
export LC_ALL="ja_JP.UTF-8"
export LANG="ja"

#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/pgsql/lib

export KEYTIMEOUT=1

#########################
######################### EXTRA

# bindkey
bindkey "^[f" vi-forward-word
bindkey "^[b" vi-backward-word 

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
HISTSIZE=60000 # on memory
SAVEHIST=70000

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



# load functions
function load_functions(){
  local function_path=$1
  if [[ -f $function_path ]]; then
    fpath=($function_path $fpath)
    autoload -U "$function_path/*(:t)"
  fi
}

load_functions "~/.zsh/completion"
load_functions "~/.zsh/commands"

# functions
[[ -f ~/.zsh/functions/functions ]] && . ~/.zsh/functions/functions
[[ -f ~/.zsh/functions/printpdf ]] && . ~/.zsh/functions/printpdf
[[ -f ~/.zsh/functions/bgm ]] && . ~/.zsh/functions/bgm
[[ -f ~/.zsh/functions/pidwait ]] && . ~/.zsh/functions/pidwait

#[[ -f ~/.zsh/functions/z.sh ]] && . ~/.zsh/functions/z.sh

# ls color
case "${OSTYPE}" in
    freebsd*|darwin*)
        alias ls="ls -G -w"
        ;;
    linux*)
        alias ls="ls --color"
        ;;
esac
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
