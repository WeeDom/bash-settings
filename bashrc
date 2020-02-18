# Git branch in prompt.

parse_git_branch() {

    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'

}
#~/.ssh-find-agent -a || eval $(ssh-agent)
set completion-ignore-case on
export BASH_SILENCE_DEPRECATION_WARNING=1
export PS1="\u@\[\033[0;94m\]flowmoco-odoo \w\[\033[32m\]\$(parse_git_branch)\[\033[00m\]\n$ "
test -f ~/.git-completion.bash && . $_
test -f ~/.console/console.rc && . $_

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

}

export PATH=~/Library/Python/3.4/bin:~/.local/bin:$PATH
alias sshaws="ssh ec2-54-201-21-17.us-west-2.compute.amazonaws.com"
alias sshggmr="ssh 89.234.59.147"
alias sshbq="ssh 134.213.122.126"
alias sshbq-staging="ssh 134.213.122.125"
alias go_bz_api="cd ~/PhpstormProjects/bluezone/api/web/modules/custom/bz_api/"
alias sshproxy="ssh -A 35.177.40.241"
alias sshbz="ssh -A 35.176.88.6"
alias updatedb="sudo /usr/libexec/locate.updatedb"

export PATH=/usr/local/lib/python3.7:$PATH


# Run twolfson/sexy-bash-prompt
. ~/.bash_prompt
