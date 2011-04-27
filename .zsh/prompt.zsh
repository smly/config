# -*- shell-script -*-

#########################
######################### PROMPT

function _git_compute_vars() {
    export __ZSH_GIT_STATE=
    export __ZSH_GIT_DIR=

    local git_dir state branch

    git_dir=$(git rev-parse --git-dir 2> /dev/null) || return

    if test -d "$git_dir/../.dotest"; then
        if test -f "$git_dir/../.dotest/rebasing"; then
            state="rebase"
        elif test -f "$git_dir/../.dotest/applying"; then
            state="am"
        else
            state="am/rebase"
        fi
        branch="$(git symbolic-ref HEAD 2>/dev/null)"
    elif test -f "$git_dir/.dotest-merge/interactive"; then
        state="rebase-i"
        branch="$(cat "$git_dir/.dotest-merge/head-name")"
    elif test -d "$git_dir/.dotest-merge"; then
        state="rebase-m"
        branch="$(cat "$git_dir/.dotest-merge/head-name")"
    elif test -f "$git_dir/MERGE_HEAD"; then
        state="merge"
        branch="$(git symbolic-ref HEAD 2>/dev/null)"
    else
        test -f "$git_dir/BISECT_LOG" && state="bisect"
        branch="$(git symbolic-ref HEAD 2>/dev/null)" || \
            branch="$(git describe --exact-match HEAD 2>/dev/null)" || \
            branch="$(cut -c1-7 "$git_dir/HEAD")..."
    fi

    branch="${branch#refs/heads/}"

    if test "$state" ; then
        state=":$state"
    fi

    case $git_dir in 
        .git) git_dir="$(pwd)/.git";;
    esac 

    export __ZSH_GIT_STATE="%{$bg[green]%}%{$fg[black]%} ${branch}${state} %{$reset_color%}"
    export __ZSH_GIT_DIR="${${git_dir:h}/$HOME/~}"
}

function _prompt_compute_vars() {
    _git_compute_vars

    local pdate
    pdate=$(date +"%m/%d %H:%M")
    export __ZSH_RPROMPT_DATE="$pdate"

    local git_dir
    git_dir=${${__ZSH_GIT_DIR}%% }

    local short
    short="${PWD/$HOME/~}"

    if test -z "$git_dir" ; then
            export __ZSH_RPROMPT_DIR="$short"
            return
    fi

    local lead rest
    lead=$git_dir
    rest=${${short#$lead}#/}

    export __ZSH_RPROMPT_DIR="$lead%{$fg[cyan]%}/$rest"
}

function _git_preexec_update_vars() {
    case "$(history $HISTCMD)" in 
        *git*) _git_compute_vars ;;
    esac
}

setopt prompt_subst

_prompt_compute_vars


# Attribute codes:
# 00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
# Text color codes:
# 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
# Background color codes:
# 40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white
if [[ $HOSTNAME = "sage" ]]; then
  PROMPT='%{$fg[green]%}${WINDOW:+"$WINDOW"}$'
elif [[ $VENDOR = "apple" ]]; then
  PROMPT='%{$fg[green]%}${WINDOW:+"$WINDOW"}$'
elif [[ $HOSTNAME = "hofmann" ]]; then
  PROMPT='%{$fg[red]%}${HOSTNAME}${WINDOW:+"$WINDOW"}$'
else
  PROMPT='%{$fg[green]%}${HOSTNAME}${WINDOW:+"$WINDOW"}$'
fi

#PROMPT=$PROMPT'%{$fg[green]%}${USER}'
PROMPT=$PROMPT'%{$reset_color%} '

RPROMPT='${__ZSH_GIT_STATE}'
RPROMPT=$RPROMPT'%{$fg[yellow]%}['       # [
RPROMPT=$RPROMPT'${__ZSH_RPROMPT_DIR}'   # rprompt_dir (git dir)
RPROMPT=$RPROMPT'%{$fg[red]%}:%!'        # # of history
RPROMPT=$RPROMPT'%{$fg[yellow]%}]'       # ]
RPROMPT=$RPROMPT'%{$fg[white]%}(${__ZSH_RPROMPT_DATE})'  # date
RPROMPT=$RPROMPT'%{$reset_color%}'       # reset
