caps_to_escape() {
	setxkbmap -option caps:escape
}

setup_vim() {
    cd ~/bash-settings
    git submodule update --init --recursive
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
export PS1="\u@\[\033[0;94m\]scaff \w\[\033[32m\]\$(parse_git_branch)\[\033[00m\]\n$ "
test -f ~/.git-completion.bash && . $_
test -f ~/.console/console.rc && . $_
export PATH=$PATH:/usr/local/Cellar/openvpn/2.5.1/sbin

cdn() {
    cd $(printf "%0.s../" $(seq 1 $1 ));
}

mkcd() {
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}
add_agent() {
    eval `ssh-agent`
    ssh-add
}

remove_spaces() {
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

laravel-clear-cache() {
if [ -f artisan ]; then
    echo "Clearing Laravel caches..."
    php artisan cache:clear
    php artisan config:clear
    php artisan view:clear
    php artisan route:clear
    php artisan optimize:clear
    echo "Rebuilding optimized files..."
    php artisan config:cache
    php artisan route:cache
    echo "Done!"
else
    echo "artisan file not found. Please navigate to your Laravel project root."
fi
}

function docker() {
  if [[ "$1" == "volume" && "$2" == "prune" ]]; then
    echo "⚠️  You're about to remove **unused** Docker volumes."
    echo
    echo "📦 These volumes will be deleted:"
    docker volume ls -f dangling=true --format '{{.Name}}'

    echo
    read -p "❓ Are you sure you want to proceed? (y/N): " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
      command docker "$@"
    else
      echo "🛑 Aborted."
    fi
    return
  fi

  command docker "$@"
}

git config --global core.editor "vi"
alias docker-compose="export HOST_UID=$(id -u) && export HOST_GID=$(id -g) && docker-compose"
alias dc="docker-compose"

alias http_here="python3 -m http.server 10234"
alias venv="source ~/venv/bin/activate"
export PROMPT_GIT_STATUS_COLOR=$(tput setaf 130)
export PROMPT_PREPOSITION_COLOR=$(tput setaf 39)
. ~/sexy-bash-prompt/.bash_prompt
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export DOCKER_HOST=unix:///var/run/docker.sock

# ~/.bashrc (SSH context visual prompt)

# Only change prompt if you're SSH'd in
if [ -n "$SSH_CONNECTION" ]; then
  PS1="\[\e[41m\]\u@\h [REMOTE] \$(parse_git_branch) \[\e[0m\]\w\$ "
fi
