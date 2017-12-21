execute pathogen#infect()

filetype plugin indent on
syntax on
autocmd FileType javascript setlocal shiftwidth=4 expandtab				
syntax enable           " enable syntax processing
"set number
"set tabstop=4       " number of visual spaces per TAB
"set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4
set expandtab       " tabs are spaces
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
"filetype indent on      " load filetype-specific indent files
set wildmenu            " visual autocomplete for command menu
set showmatch           " highlight matching [{()}]
set paste               " always be ready to take CTRL/CMD+V
set autoindent
" search
set hidden              " keep undo history
nnoremap <leader><space> :nohlsearch<CR>

"  movement

" move vertically by visual line
nnoremap j gj
nnoremap k gk
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>
