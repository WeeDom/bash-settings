# Git branch in prompt.

parse_git_branch() {

    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'

}
~/.ssh-find-agent -a || eval $(ssh-agent)
set completion-ignore-case on
export PS1="\u@\[\033[0;94m\]\h \w\[\033[32m\]\$(parse_git_branch)\[\033[00m\]\n$ "
test -f ~/.git-completion.bash && . $_
test -f ~/.console/console.rc && . $_

function cdn() {
    cd $(printf "%0.s../" $(seq 1 $1 ));
}

function add_agent() {
    eval `ssh-agent`
    ssh-add

}

export PATH=~/Library/Python/3.4/bin:~/.local/bin:$PATH
alias sshaws="ssh ec2-54-201-21-17.us-west-2.compute.amazonaws.com"
alias sshggmr="ssh 89.234.59.147"
alias sshbq="ssh 134.213.122.126"
alias sshbq-staging="ssh 134.213.122.125"
alias go_bz_api="cd ~/PhpstormProjects/bluezone/api/web/modules/custom/bz_api/"
alias sshproxy="ssh -A 35.176.59.198"
alias sshbz="ssh -A 35.176.88.6"
alias updatedb="sudo /usr/libexec/locate.updatedb"
function copy_bash_vim() {
	scp .vim/autoload/* $1:/home/dominic.pain/.vim/autoload/
	scp -r .vim/bundle/* $1:/home/dominic.pain/.vim/bundle/
	scp .vimrc $1:/home/dominic.pain/.vimrc
	scp .bashrc $1:/home/dominic.pain/.bashrc
	scp .tmux.conf $1:/home/dominic.pain/.tmux.conf
}

export NVM_DIR="/Users/dominic.pain/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
# Run twolfson/sexy-bash-prompt
. ~/.bash_prompt
