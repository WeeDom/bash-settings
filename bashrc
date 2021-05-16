function caps_to_escape() {
	setxkbmap -option caps:escape
}
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
vmuuid() {
    VBOXUUID=`VBoxManage list runningvms | awk -F"[{}]" '{ print $2 }'`
    if [ -z $VBOXUUID ]; then
        echo "No vm is running. You must have a single running VM for this script to work."
       exit 1
    else
        export VBOXUUID=$VBOXUUID
        echo $VBOXUUID
    fi
}

vbhelp() {
    VBoxManage --help | less
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

alias http_here="python3.8 -m http.server 10234"
alias venv="source venv/bin/activate"

. ~/sexy-bash-prompt/.bash_prompt
alias vpn="cd; sudo openvpn --config ~/dominic.pain__ssl_vpn_config.ovpn"
alias setup="cd /$HOME/Sites/core-local-scripts/scripts && ./setup.sh"
alias start="cd /$HOME/Sites/core-local-scripts/scripts && ./start.sh"
alias stop="cd /$HOME/Sites/core-local-scripts/scripts && ./stop.sh"
alias blackfire-curl="cd /$HOME/Sites/core && docker-compose exec blackfire blackfire curl"
alias updatedb="sudo /usr/libexec/locate.updatedb"
alias cdscripts="cd $HOME/Sites/core-local-scripts/scripts/"
