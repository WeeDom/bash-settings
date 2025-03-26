rebuild_full_stack() {
    docker stop $(docker ps -a -q)
    docker rmi -f $(docker image ls -q)
    cd ~/dev/concrete5
    docker build --no-cache .
    docker compose --verbose up -d
}


function caps_to_escape() {
	setxkbmap -option caps:escape
}
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

git_big_files() {
    git rev-list --objects --all |
        git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' |
        sed -n 's/^blob //p' |
        sort --numeric-sort --key=2 |
        cut -c 1-12,41- |
        $(command -v gnumfmt || echo numfmt) --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest
}

set completion-ignore-case on
export BASH_SILENCE_DEPRECATION_WARNING=1
set completion-ignore-case on
export PS1="\u@\[\033[0;94m\]localhost \w\[\033[32m\]\$(parse_git_branch)\[\033[00m\]\n$ "
test -f ~/.git-completion.bash && . $_
test -f ~/.console/console.rc && . $_
export PATH=$PATH:/usr/local/Cellar/openvpn/2.5.1/sbin

function cdn() {
    cd $(printf "%0.s../" $(seq 1 $1 ));
}

function mkcd() {
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}
function add_agent() {
    eval `ssh-agent`
    ssh-add
}

function remove_spaces() {
    for oldname in *
    do
        newname=`echo $oldname | sed -e 's/ /_/g'`
        if [ "$newname" = "$oldname" ]
        then
            continue
        fi
        if [ -e "$newname" ]
        then
            echo Skipping "$oldname", because "$newname" exists
        else
            mv "$oldname" "$newname"
        fi
    done
}

. ~/sexy-bash-prompt/.bash_prompt

alias http_here="python3 -m http.server 10234"
alias venv="source venv/bin/activate"
alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export DOCKER_HOST=unix:///var/run/docker.sock
