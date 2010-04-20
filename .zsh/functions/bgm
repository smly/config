function bgm() {
    while (true); do mplayer $1 -novideo 1>& /dev/null; sleep 3; done
}
function bgm_alltrack() {
    while (true); do for i in $1; do mplayer $i -novideo 1>& /dev/null; sleep 1; done; done
}
