#!/bin/bash

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "you do have your keys set up, right?"
echo "This script will try to set up git, bashrc and vim with Dom's favourite settings"
echo "set up git correctly"

echo "cd ~"
cd ~

echo "git config --global core.editor 'vim'"
git config --global core.editor 'vim'
echo "git config --global user.name 'Dominic Pain'"
git config --global user.name 'Dominic Pain'
echo "git config --global user.email 'dominic_pain@hotmail.com'"
git config --global user.email 'dominic_pain@hotmail.com'
echo "sudo apt-get update"
sudo apt-get update
echo "sudo apt-get -y install ripgrep tmux tree"
sudo apt-get -y install tmux ripgrep tmux tree
echo "rm .tmux.conf"
echo "ln -sfn bash-settings/tmux.conf .tmux.conf"
ln -sfn bash-settings/tmux.conf .tmux.conf

# Symlink .bashrc
ln -sfn "${REPO_DIR}/bashrc" "${HOME}/.bashrc"

# Symlink .tmux.conf if present
if [ -f "${REPO_DIR}/tmux.conf" ]; then
  ln -sfn "${REPO_DIR}/tmux.conf" "${HOME}/.tmux.conf"
fi

# Symlink vim configuration if present
if [ -d "${REPO_DIR}/vim" ]; then
  ln -sfn "${REPO_DIR}/vim" "${HOME}/.vim"
fi

# URLs for dependencies
SEXY_BASH_PROMPT_URL="${SEXY_BASH_PROMPT_URL:-https://github.com/twolfson/sexy-bash-prompt.git}"
FZF_URL="${FZF_URL:-https://github.com/junegunn/fzf.git}"

# Clone sexy-bash-prompt if not already present
if [ ! -d "${HOME}/sexy-bash-prompt" ]; then
  git clone "${SEXY_BASH_PROMPT_URL}" "${HOME}/sexy-bash-prompt"
fi

# Clone fzf if not already present
if [ ! -d "${HOME}/fzf" ]; then
  git clone "${FZF_URL}" "${HOME}/fzf"
  # Install fzf key bindings and completion (non-interactively)
  if [ -x "${HOME}/fzf/install" ]; then
    yes | "${HOME}/fzf/install" --key-bindings --completion --no-update-rc
  fi
fi

echo "Symlinks created and dependencies cloned."
