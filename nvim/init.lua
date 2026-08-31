-- Neovim entry point.
--
-- Deliberately thin: the real configuration lives in ../vimrc so vim and nvim
-- can never drift apart. Anything nvim-only goes at the bottom of this file.
--
-- ~/.config/nvim is a symlink to this directory (see setup-new-host.sh), so a
-- `git pull` in bash-settings is all a new machine needs.

-- Work out the repo root from this file's own location rather than hardcoding
-- /home/weedom, so this survives a different $HOME or checkout path.
local repo = vim.fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':p:h:h')
local vimdir = repo .. '/vim'

-- YouCompleteMe needs a working python3 provider, which nvim gets from a
-- pynvim install. Ubuntu's system python is externally managed, so
-- setup-new-host.sh puts pynvim in this venv rather than needing sudo.
local py = vim.fn.expand('~/.local/opt/nvim-venv/bin/python')
if vim.uv.fs_stat(py) then
  vim.g.python3_host_prog = py
end

-- pathogen#infect() and the plugins under vim/bundle are found via runtimepath.
vim.opt.runtimepath:prepend(vimdir)
vim.opt.runtimepath:append(vimdir .. '/after')
-- vim/pack/github/start/copilot.vim is loaded by the built-in package mechanism,
-- which reads packpath (packages load after this file, so prepending here works).
vim.opt.packpath:prepend(vimdir)

vim.cmd.source(repo .. '/vimrc')

-- nvim-only overrides ------------------------------------------------------

-- nvim ships a default colorscheme that paints Normal with its own blue-grey
-- background; vim leaves Normal cleared so the terminal's background shows
-- through. The bundled 'vim' colorscheme restores the legacy behaviour, so
-- both editors sit on the terminal background. background=light mirrors what
-- vim picks by default -- without it nvim may guess 'dark' and hand the vim
-- scheme a different (unreadable on a light terminal) syntax palette.
vim.opt.background = 'light'
vim.cmd.colorscheme('vim')

-- vimrc points 'directory' at ~/.vim/swap, which vim is already using. Give
-- nvim its own so editing the same file in both doesn't trip swap warnings.
vim.opt.directory = vim.fn.stdpath('state') .. '/swap//'
vim.lsp.config('pyright', {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', '.git' },
})

vim.lsp.enable('pyright')
