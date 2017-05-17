# Git branch in prompt.

parse_git_branch() {

    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'

}
set completion-ignore-case on
export PS1="\u@\[\033[0;94m\]\h \w\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "
test -f ~/.git-completion.bash && . $_
test -f ~/.console/console.rc && . $_

function cdn() {
    cd $(printf "%0.s../" $(seq 1 $1 ));
}

export PATH=~/Library/Python/3.4/bin:~/.local/bin:$PATH
alias sshaws="ssh ec2-54-201-21-17.us-west-2.compute.amazonaws.com"
alias sshggmr="ssh 89.234.59.147"
function copy_bash_vim() {
	scp .vim/autoload/* ec2-54-201-21-17.us-west-2.compute.amazonaws.com:/home/dominic.pain/.vim/autoload/
	scp -r .vim/bundle/* ec2-54-201-21-17.us-west-2.compute.amazonaws.com:/home/dominic.pain/.vim/bundle/
	scp .vimrc ec2-54-201-21-17.us-west-2.compute.amazonaws.com:/home/dominic.pain/.vimrc
	scp .bashrc ec2-54-201-21-17.us-west-2.compute.amazonaws.com:/home/dominic.pain/.bashrc
	scp .tmux.conf ec2-54-201-21-17.us-west-2.compute.amazonaws.com:/home/dominic.pain/.tmux.conf
}

export NVM_DIR="/Users/dominic.pain/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
