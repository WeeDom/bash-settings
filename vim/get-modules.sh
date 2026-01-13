#!/bin/sh

git submodule add https://github.com/scrooloose/nerdcommenter.git nerdcommenter
git submodule add https://github.com/scrooloose/nerdtree.git nerdtree
git submodule add https://github.com/tpope/vim-surround.git surround
git submodule add https://github.com/hail2u/vim-css3-syntax.git css3
git submodule add https://github.com/Townk/vim-autoclose.git autoclose
git submodule add https://github.com/tpope/vim-fugitive.git fugitive
git submodule add https://github.com/nvie/vim-flake8.git


git submodule init bufexplorer
git submodule init nerdcommenter
git submodule init nerdtree
git submodule init surround
git submodule init css3
git submodule init autoclose
git submodule init fugitive
git submodule init flake8
