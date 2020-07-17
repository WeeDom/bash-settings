function caps_to_escape() {
	setxkbmap -option caps:escape
}
#~/.ssh-find-agent -a || eval $(ssh-agent)
set completion-ignore-case on
export BASH_SILENCE_DEPRECATION_WARNING=1
export PS1="\u@\[\033[0;94m\]flowmoco-odoo \w\[\033[32m\]\$(parse_git_branch)\[\033[00m\]\n$ "
test -f ~/.git-completion.bash && . $_
test -f ~/.console/console.rc && . $_
export BASH_SILENCE_DEPRECATION_WARNING=1
#alias kubectl="microk8s.kubectl"

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

function start_odoo() {
    docker-compose run -p 9069:8069 msukstaging_odoo bash
    echo "odoo "$@" "${DB_ARGS[@]}" --dev=all --logfile=/var/log/odoo/odoo-server.log"
    echo "docker exec -it 329a2a3fe9a7 bash"
    docker-compose up -d msukstaging_db

function getktoken() {
    ktoken=$( kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}') | grep "^token" | awk '{split($0,a,":"); gsub(/ /,"",a[2]); print a[2]}')
    echo $ktoken
    if hash xclip 2>/dev/null; then
        echo -n $ktoken | xclip -selection clipboard
    fi
}

export PATH=~/Library/Python/3.4/bin:~/.local/bin:$PATH
alias sshproxy="ssh -A dominic.pain@35.177.40.241"
alias machine="docker-machine"
alias http_here="python2.7 -m SimpleHTTPServer 10234"
alias venv="source venv/bin/activate"
set completion-ignore-case On

export PATH=/usr/local/lib/python3.7:$PATH


# Run twolfson/sexy-bash-prompt
. ~/.bash_prompt
. ~/sexy-bash-prompt/.bash_prompt
source <(kubectl completion bash)
