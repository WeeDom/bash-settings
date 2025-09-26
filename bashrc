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

if [ -f /etc/this-is-smp-production ]; then
    export PS1="\[\e[41m\]\u (PROD)\[\e[0m\] in\$(parse_git_branch)\[\033[00m\] \w $ "
elif [ -f /etc/this-is-smp-staging ]; then
    export PS1="\[\e[43m\]\u (STAGING)\[\e[0m\] in\$(parse_git_branch)\[\033[00m\] \w $ "
else
    . ~/sexy-bash-prompt/.bash_prompt
fi

git config --global core.editor "vi"

export DOCKER_HOST=unix:///var/run/docker.sock
# install it, if it's available.
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/bin/docker_complete.sh ] && source ~/bin/docker_complete.sh
# function to open the search pane, using batcat (cat on steroids)
fzf_open_with_preview() {
  local file
  file=$(fzf --tmux --preview 'batcat --style=numbers --color=always --line-range=:300 {}' ) && code "$file"
}
# bind it to CTRL+F (only in interactive shells)
[[ $- == *i* ]] && bind -x '"\C-f": fzgrep'
fzgrep() {
  local selected file line

  selected=$(rg --no-heading --line-number "${*:-.}" \
    | fzf --ansi \
    	  --tmux \
          --delimiter : \
          --preview 'batcat --style=numbers --color=always --highlight-line {2} {1}' \
          --preview-window=up:60%)

  [ -z "$selected" ] && return 1

  file=$(cut -d: -f1 <<< "$selected")
  line=$(cut -d: -f2 <<< "$selected")

  code -g "$file:$line"
}
#
#
#
#functions get defined here so they're declared earlier than the aliases
dc() {
  if [[ -n "$SSH_CONNECTION" ]]; then
    echo "⚠️  Refusing to run docker compose with dev config in remote SSH session (SSH_CONNECTION detected)"
    return 1
  fi

  CMD="docker compose -f ~/main/docker-compose.full-dev.yml"

  echo "running $CMD $@"
  eval $CMD "$@"
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

docker_mem() {
    ~/bin/docker_mem.sh
}

gdrive_mount() {
    rclone mount "WeeDomGDrive": ~/gdrive --vfs-cache-mode writes &
}

gdrive_umount() {
    fusermount -u ~/gdrive
}

# Update vim plugin submodules
update-vim-plugins() {
  echo "📦 Updating Vim plugins..."
  cd ~/bash-settings || return
  git pull --recurse-submodules
  git submodule foreach 'branch=$(git rev-parse --abbrev-ref HEAD); git checkout $branch && git pull'
  echo "✅ Vim plugins updated."
}

## aliases go here
alias http_here="python3 -m http.server 10234"
alias venv="source ~/venv/bin/activate"
alias psqlx='docker compose exec db psql -U scaffadmin -d scaffsmart -x'


