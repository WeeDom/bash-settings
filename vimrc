execute pathogen#infect()

let g:ycm_confirm_extra_conf = 0
let g:ycm_server_python_interpreter = '/usr/bin/python2.7'
set directory=$HOME/.vim/swap/

filetype plugin indent on
syntax on
colorscheme evening
set rnu number
autocmd FileType * setlocal shiftwidth=4 expandtab
syntax enable           " enable syntax processing
set number
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4
set expandtab       " tabs are spaces
set showcmd             " show command in bottom bar
set nocursorline          " highlight current line
"filetype indent on      " load filetype-specific indent files
set wildmenu            " visual autocomplete for command menu
set showmatch           " highlight matching [{()}]
set paste               " always be ready to take CTRL/CMD+V
set autoindent
" search
set hidden              " keep undo history
nnoremap <leader><space> :nohlsearch<CR>
let python_highlight_all = 1
"  movement

let @d = 'i	import pdb; pdb.set_trace()'
" move vertically by visual line
nnoremap j gj
nnoremap k gk
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

au BufNewFile,BufRead,BufWritePre *
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
" remove trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
