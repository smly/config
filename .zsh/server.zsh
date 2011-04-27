# server list
clientarch=(hofmann sage chung sussman)
serveru904=(pine2 pine3 pine4 pine5)
serveru804=(cacao parsley papaya tomato carrot radish pepper bean pine6)
servergent=(cactus chasen)
serverso10=(pine1 pine0)
servermacx=(fir apple)

typeset -A HOST_OS_HASH
for i in $clientarch; do HOST_OS_HASH+=($i "Arch Linux") done
for i in $serveru904; do HOST_OS_HASH+=($i "Ubuntu9.04") done
for i in $serveru804; do HOST_OS_HASH+=($i "Ubuntu8.04") done
for i in $servergent; do HOST_OS_HASH+=($i "Gentoo Linux") done
for i in $serverso10; do HOST_OS_HASH+=($i "Solaris 10") done
for i in $servermacx; do HOST_OS_HASH+=($i "Apple Mac OS") done

function pcolor() {
    for ((f = 0; f < 255; f++)); do
        printf "\e[38;5;%dm %3d#\e[m" $f $f
        if [[ $f%8 -eq 7 ]] then
            printf "\n"
        fi
    done
    echo
}

local HOSTNAME=`uname -n`
local COLOR_ARCH='\e[38;5;69m'
local COLOR_UBUN='\e[38;5;166m'
local COLOR_GENT='\e[38;5;135m'
local RIGHTC='\e[m'
local COLOR_BOLD='\e[1m'
local COLOR_LINE='\e[4m'
local COLOR_BLINK='\e[5m'

HOST_OS=$HOST_OS_HASH[$HOSTNAME]
[ -z $HOST_OS ] && HOST_OS="unknown"
[[ $VENDOR = "apple" ]] && HOST_OS="Mac OS"

export HOST_OS
local MSG=""
case $HOST_OS in
    Arch*)
        MSG="${COLOR_ARCH}${COLOR_BOLD}$HOSTNAME ${COLOR_BLINK}($HOST_OS)${RIGHTC}!!" ;;
    Ubuntu*)
        MSG="${COLOR_UBUN}${COLOR_BOLD}$HOSTNAME ${COLOR_BLINK}($HOST_OS)${RIGHTC}!!" ;;
    Gentoo*)
        MSG="${COLOR_GENT}${COLOR_BOLD}$HOSTNAME ${COLOR_BLINK}($HOST_OS)${RIGHTC}!!" ;;
    *)
        MSG="${COLOR_BOLD}$HOSTNAME ${COLOR_BLINK}($HOST_OS)${RIGHTC}!!" ;;
esac
echo "／(^o^)＼ here is $MSG"

screen -list
