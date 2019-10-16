# Git branch in prompt.

caps_to_escape() {
	setxkbmap -option caps:escape
}
#~/.ssh-find-agent -a || eval $(ssh-agent)
set completion-ignore-case on
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

function getktoken() {
    ktoken=$( kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}') | grep "^token" | awk '{split($0,a,":"); gsub(/ /,"",a[2]); print a[2]}')
    echo $ktoken
    if hash xclip 2>/dev/null; then
        echo -n $ktoken | xclip -selection clipboard
    fi
}

export PATH=~/Library/Python/3.4/bin:~/.local/bin:$PATH
alias go_bz_api="cd ~/PhpstormProjects/bluezone/api/web/modules/custom/bz_api/"
alias sshproxy="ssh -A dominic.pain@35.177.40.241"
alias sshbz="ssh -A 35.176.88.6"
alias machine="docker-machine"
alias http_here="python2.7 -m SimpleHTTPServer 10234"
set completion-ignore-case On

# Run twolfson/sexy-bash-prompt
. ~/sexy-bash-prompt/.bash_prompt
source <(kubectl completion bash)
