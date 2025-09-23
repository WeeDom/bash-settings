#!/usr/bin/env bash
set -euo pipefail

# This script sets up the bash environment on a fresh machine.
# It symlinks the repository's bashrc into the user's home directory and
# clones necessary repositories for prompt and fzf.

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
