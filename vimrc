execute pathogen#infect()

filetype plugin on
let g:ycm_confirm_extra_conf = 0
let g:ycm_server_python_interpreter = '/usr/bin/python3'
set directory=$HOME/.vim/swap/
runtime macros/matchit.vim
filetype plugin indent on
syntax on
set rnu number
autocmd FileType * setlocal shiftwidth=4 expandtab
syntax enable           " enable syntax processing
set expandtab       " tabs are spaces
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4
set showcmd             " show command in bottom bar
set nocursorline          " highlight current line
filetype indent on      " load filetype-specific indent files
set wildmenu            " visual autocomplete for command menu
set showmatch           " highlight matching [{()}]
set nopaste               " always be ready to take CTRL/CMD+V
imap <C-p> <C-o>:set invpaste paste?<CR>
set autoindent
set hidden              " keep undo history
nnoremap <leader><space> :nohlsearch<CR>
let python_highlight_all = 1
let @d = 'i	import pdb; pdb.set_trace() # noqa E702'
" move vertically by visual line
nnoremap j gj
nnoremap k gk
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>
" Accept Copilot suggestion with Tab (optional)
" imap <silent><script><expr> <Tab> copilot#Accept("\<CR>")

" Accept Copilot suggestion with Ctrl+L
imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")

au! BufNewFile,BufRead,BufWritePre *.feature
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
" remove trailing whitespace
autocmd BufWritePre *.feature %s/\s\+$//e

au! BufNewFile,BufRead,BufWritePre *
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
" remove trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

autocmd BufWritePost *.py call flake8#Flake8()

