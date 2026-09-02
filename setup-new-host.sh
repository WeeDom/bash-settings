#!/bin/bash

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "cd ~"
cd ~

echo "git config --global core.editor 'vim'"
git config --global core.editor 'vim'
echo "git config --global user.name 'Dominic Pain'"
git config --global user.name 'Dominic Pain'
echo "git config --global user.email 'dominic_pain@hotmail.com'"
git config --global user.email 'dominic_pain@hotmail.com'
echo "sudo apt-get update --allow-releaseinfo-change"
sudo apt-get update --allow-releaseinfo-change
echo "sudo apt-get -y install ripgrep tmux tree"
# curl + python3-venv are needed by the neovim install below
sudo apt-get -y install tmux ripgrep tree vim exuberant-ctags curl python3-venv
echo "ln -sfn bash-settings/tmux.conf .tmux.conf"
ln -sfn bash-settings/tmux.conf .tmux.conf

ln -sfn "${REPO_DIR}/bashrc" "${HOME}/.bashrc"
ln -sfn "${REPO_DIR}/vim" "${HOME}/.vim"

# --- neovim ---------------------------------------------------------------
# Installed from the official tarball into ~/.local rather than apt, because
# distro packages lag several releases behind. Bump NVIM_VERSION to upgrade.
NVIM_VERSION="${NVIM_VERSION:-v0.12.4}"

case "$(uname -m)" in
  x86_64|amd64)  NVIM_ARCH="x86_64" ;;
  aarch64|arm64) NVIM_ARCH="arm64" ;;
  *) echo "neovim: unsupported architecture $(uname -m), skipping" >&2; NVIM_ARCH="" ;;
esac

NVIM_PREFIX="${HOME}/.local/opt/nvim-${NVIM_VERSION}"
if [ -n "${NVIM_ARCH}" ] && [ ! -x "${NVIM_PREFIX}/bin/nvim" ]; then
  echo "installing neovim ${NVIM_VERSION} (${NVIM_ARCH})"
  NVIM_TMP="$(mktemp -d)"
  curl -fsSL -o "${NVIM_TMP}/nvim.tar.gz" \
    "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-${NVIM_ARCH}.tar.gz"
  tar -xzf "${NVIM_TMP}/nvim.tar.gz" -C "${NVIM_TMP}"
  mkdir -p "${HOME}/.local/opt"
  mv "${NVIM_TMP}/nvim-linux-${NVIM_ARCH}" "${NVIM_PREFIX}"
  rm -rf "${NVIM_TMP}"
fi
if [ -x "${NVIM_PREFIX}/bin/nvim" ]; then
  # ~/.local/bin is already on PATH via bashrc
  mkdir -p "${HOME}/.local/bin"
  ln -sfn "${NVIM_PREFIX}/bin/nvim" "${HOME}/.local/bin/nvim"
fi

# nvim's python3 provider (needed by YouCompleteMe) requires pynvim. A venv
# avoids both sudo and Ubuntu's externally-managed-environment pip refusal;
# nvim/init.lua points g:python3_host_prog at it.
NVIM_VENV="${HOME}/.local/opt/nvim-venv"
if [ ! -x "${NVIM_VENV}/bin/python" ]; then
  python3 -m venv "${NVIM_VENV}"
fi
"${NVIM_VENV}/bin/pip" install -q --upgrade pynvim

# nvim reads ../vimrc and the vim/ plugins, so there is only one config to keep
mkdir -p "${HOME}/.config"
ln -sfn "${REPO_DIR}/nvim" "${HOME}/.config/nvim"

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

echo "sudo apt -y autoremove"
sudo apt -y autoremove
