## safety and env

set completion-ignore-case on
export BASH_SILENCE_DEPRECATION_WARNING=1
export PATH=$PATH:/usr/local/Cellar/openvpn/2.5.1/sbin
export PS1="\u@\[\033[0;94m\]scaff \w\[\033[32m\]\$(parse_git_branch)\[\033[00m\]\n$ "
test -f ~/.git-completion.bash && . $_
test -f ~/.console/console.rc && . $_
export EDITOR=vim
export VISUAL=vim
export NVM_DIR="$HOME/.nvm"

export PROMPT_GIT_STATUS_COLOR=$(tput setaf 130)
export PROMPT_PREPOSITION_COLOR=$(tput setaf 39)
. ~/sexy-bash-prompt/.bash_prompt
git config --global core.editor "vi"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if ! pgrep ssh-agent > /dev/null; then
    echo "Starting ssh-agent..."
  eval $(ssh-agent -s)
  ssh-add
fi


export DOCKER_HOST=unix:///var/run/docker.sock
## make it obvious that we're not local
if [ -n "$SSH_CONNECTION" ]; then
  PS1="\[\e[41m\]\u@\h [REMOTE] \$(parse_git_branch) \[\e[0m\]\w\$ "
fi

#functions get defined here so they're declared earlier than the aliases
dc() {
  if [[ -n "$SSH_CONNECTION" ]]; then
    echo "⚠️  Refusing to run docker compose with dev config in remote SSH session (SSH_CONNECTION detected)"
    return 1
  fi

  echo docker compose -f ~/main/docker-compose.yml -f ~/main/docker-compose.dev.yml "$@"
  docker compose -f ~/main/docker-compose.yml -f ~/main/docker-compose.dev.yml "$@"
}

caps_to_escape() {
	setxkbmap -option caps:escape
}

clip() {
  local cmd_output
  cmd_output="$("$@" 2>&1)" || return 1
  {
    echo "$*"
    echo "--------------------"
    echo "$cmd_output"
  } | tee >(wl-copy >/dev/null)
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

## aliases go here
alias http_here="python3 -m http.server 10234"
alias venv="source ~/venv/bin/activate"
alias psqlx='docker compose exec db psql -U scaffadmin -d scaffsmart -x'


# ~/.bashrc (SSH context visual prompt)


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
