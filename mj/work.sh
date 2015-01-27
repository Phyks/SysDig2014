#!/usr/bin/zsh

alias simul=../simulateur/main.native
function rebuild_simul {
    cd ../simulateur/
    echo "## In" $(pwd)
    echo 
    echo "## Building debug target."
    ocamlbuild main.d.byte -use-menhir -use-ocamlfind -libs unix
    echo
    echo "## Building native target."
    ocamlbuild main.native -use-menhir -use-ocamlfind -libs unix
    cd -
    echo
    echo "## In" $(pwd)
}
alias minijazz=../minijazz/minijazz/mjc.native

function build {
    [ $1 ] && args=$1 || args=1
    echo $args" steps"
    python3 generate.py test.mj > tmp.mj &&
     	minijazz tmp.mj &&
     	simul -n $args tmp.net
}

function rebuild {
    [ $1 ] && args=$1 || args=1
    echo $args" steps"
    rm tmp_sch.net
    python3 generate.py test.mj > tmp.mj &&
     	minijazz tmp.mj &&
     	simul -n $args tmp.net
}

PS1="$FG[100]~SysDig $PS1"
