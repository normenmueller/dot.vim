set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'wincent/command-t'
Plugin 'tpope/vim-sensible'
call vundle#end()

filetype on
filetype indent on
filetype plugin on

syntax on

" M ~ ALT | D ~ Cmd
if has('gui_running')
  set macmeta
  set guioptions=egmrL
  set guifont=Menlo\ Regular:h12
endif

set lines=40
set columns=90
set cursorline
set clipboard=unnamed
set spelllang=en
set spellfile=$HOME/.vim/spell/en.utf-8.add

set expandtab
set tabstop=2
set softtabstop=2

set shiftwidth=2

" Select buffer {{{1
let g:selBufDefaultSortOrder = "path"
so $HOME/.vim/plugin/cmdalias.vim 
:call CmdAlias('ls', 'SelectBuf') 

" vim:set ft=vim et sw=2:
