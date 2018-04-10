execute pathogen#infect()

set directory=$HOME/.vim/swapfiles//

filetype plugin indent on
syntax on
set rnu
autocmd FileType javascript setlocal shiftwidth=4 expandtab
autocmd FileType xml setlocal shiftwidth=4 expandtab
syntax enable           " enable syntax processing
"set number
"set tabstop=4       " number of visual spaces per TAB
"set softtabstop=4   " number of spaces in tab when editing
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

" move vertically by visual line
nnoremap j gj
nnoremap k gk
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

au BufNewFile,BufRead,BufWritePre *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

autocmd BufWritePre * %s/\s\+$//e
augroup XML
    autocmd!
    autocmd FileType xml setlocal foldmethod=indent foldlevelstart=999 foldminlines=0
augroup END
