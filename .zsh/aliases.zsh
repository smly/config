# fast directory change
alias ..='cd .. && ls'
alias ...='cd ../.. && ls'
alias ....='cd ../../.. && ls'
alias .....='cd ../../../.. && ls'
alias ......='cd ../../../../.. && ls'
alias .......='cd ../../../../../.. && ls'

# directory stack
alias gd='dirs -v; echo -n "select number: "; read newdir; cd +"$newdir"'
alias d='dirs -v'

# short
alias du="du -h"
alias df="df -h"
alias l="ls"
alias e="emacs -nw"
alias la="ls -a"
alias ll="ls -l"
alias lh="ls -lh"
alias em="emacs -nw"
alias tgif="lang=C tgif"
alias tp="top -d 0.1"

# no spelling correnction on mv
alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'

# applications
alias gc="gcalcli"
alias gcr="gcalcli --cals=owner agenda `date -I` `date --date '20 day' -I`"

# hadoop
# alias dfsls="$HADOOP/bin/hadoop dfs -ls"
# alias dfsrm="$HADOOP/bin/hadoop dfs -rm"
# alias dfscat="$HADOOP/bin/hadoop dfs -cat"
# alias dfsrmr="$HADOOP/bin/hadoop dfs -rmr"
# alias dfsmkdir="$HADOOP/bin/hadoop dfs -mkdir"
# alias dfsput="$HADOOP/bin/hadoop dfs -put"
# alias dfsget="$HADOOP/bin/hadoop dfs -get"
# alias hadoop="$HADOOP/bin/hadoop jar"

# package manager
alias install='sudo apt-get install'
alias search='sudo apt-cache search'
alias show='sudo apt-cache show'
