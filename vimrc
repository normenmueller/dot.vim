set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Shougo/vimproc.vim'
"Plugin 'wincent/command-t'
Plugin 'eagletmt/ghcmod-vim'
Plugin 'tpope/vim-sensible'
call vundle#end()

filetype on
filetype indent on
filetype plugin on

syntax on

if has('gui_running')
  " M ~ ALT | D ~ Cmd
  set macmeta
  set guioptions=egmrL
  set guifont=Menlo\ Regular:h12
  set lines=40
  set columns=90
endif

set cursorline
set clipboard=unnamed

" Fuzzy find w/o plug-ins
"   Search down into subfolders
"   Provides tab-completion for all file-related tasks
set path+=**
"   Display all matching files when we tab complete
set wildmenu

" Spelling
set spelllang=en
set spellfile=$HOME/.vim/spell/en.utf-8.add

" <Tab> settings
set tabstop=8
set expandtab
set softtabstop=2
set shiftwidth=2

" Select buffer
let g:selBufDefaultSortOrder = "path"
so $HOME/.vim/plugin/cmdalias.vim 
:call CmdAlias('ls', 'SelectBuf') 

" ctags
command! MakeTags !ctags -R .

" netrw
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" vim:set ft=vim et sw=2:
