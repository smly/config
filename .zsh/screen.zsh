#########################
######################### SCREEN SETTINGS

if [ -n $STY ]; then
    function chpwd () {
#      _reg_pwd_screennum
        _prompt_compute_vars
#      _color_ls
        echo -n "_`dirs`\\"
    }


    function preexec() {
        _git_preexec_update_vars

        # see [zsh-workers:13180]
        # http://www.zsh.org/mla/workers/2000/msg03993.html
        emulate -L zsh
        local -a cmd; cmd=(${(z)2})
        case $cmd[1] in
            fg)
                if (( $#cmd == 1 )); then
                    cmd=(builtin jobs -l %+)
                else
                    cmd=(builtin jobs -l $cmd[2])
                fi
                ;;
            %*)
                cmd=(builtin jobs -l $cmd[1])
                ;;
            cd)
                if (( $#cmd == 2)); then
                    cmd[1]=$cmd[2]
                fi
                ;&
            *)
                echo -n "k$cmd[1]:t\\"
                prev=$cmd[1]
                return
                ;;
        esac

        local -A jt; jt=(${(kv)jobtexts})

        $cmd >>(read num rest
            cmd=(${(z)${(e):-\$jt$num}})
        echo -n "k$cmd[1]:t\\") 2>/dev/null

        prev=$cmd[1]
    }

    function precmd() {
        #local prev; prev=`history -1 | sed "s/^[ 0-9]*//" | sed "s/ .*$//"  `
        echo -n "k$:$prev\\"
    }

    chpwd
fi
