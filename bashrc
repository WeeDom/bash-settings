# Git branch in prompt.

parse_git_branch() {

    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'

}
set completion-ignore-case on
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

export PATH=~/Library/Python/3.4/bin:~/.local/bin:$PATH
alias sshaws="ssh ec2-54-201-21-17.us-west-2.compute.amazonaws.com"
alias sshggmr="ssh 89.234.59.147"
alias sshbq="ssh 134.213.122.126"
alias sshbq-staging="ssh 134.213.122.125"
alias go_bz_api="cd ~/PhpstormProjects/bluezone/api/web/modules/custom/bz_api/"
alias sshproxy="ssh 35.176.59.198"
alias sshbz="ssh 35.176.88.6"

# Run twolfson/sexy-bash-prompt
#. ~/.bash_prompt
