set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Shougo/vimproc.vim' "NOTE: cd ~/.vim/bundle/vimproc.vim; make
Plugin 'Shougo/unite.vim'   "was Plugin 'kien/ctrlp.vim'
Plugin 'qpkorr/vim-bufkill' "was Plugin 'bufkill.vim'
Plugin 'bling/vim-airline'  "alternative: powerline/powerline
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
"Plugin 'tpope/vim-unimpaired'
Plugin 'elzr/vim-json'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'altercation/vim-colors-solarized'
Plugin 'will133/vim-dirdiff'
Plugin 'normenmueller/nerdtree'
Plugin 'normenmueller/vim-scala'
call vundle#end()
filetype plugin indent on 

" Filetype detection
filetype on

" Filetype-specific indenting
filetype indent on

" Filetype-specific plugins
filetype plugin on

" Syntax highlighting
syntax on

" -----------------------------------------------------------------------------
"  Window

"set guioptions=egmrL
set guioptions=gmrL

" Always show the tab bar
set showtabline=2

" Set the command window height to 2 lines
set cmdheight=2 

" Always show a status line for window
set laststatus=2

" -----------------------------------------------------------------------------
"  Visualization

" Color schema
colorscheme atom
"colorscheme mustang

" Fonts used for the GUI version of Vim
set guifont=Source\ Code\ Pro\ ExtraLight:h12

"
set visualbell

" Wrap long lines at a character in 'breakat'
set linebreak

" Show matching bracets when text indicator is over them
set showmatch

" Show (partial) command in the last line of the screen.
set showcmd

" Display line number on the left
set number

" -----------------------------------------------------------------------------
"  Buffer

" Hide abandoned buffer rather than unloading 
set hidden

"
"set modeline

" Automatically change the current directory to edited file path 
set autochdir 

" -----------------------------------------------------------------------------
"  Edit

"
set encoding=utf-8

"
set clipboard=unnamed

" Convert tabs to spaces
set expandtab

"
set shiftwidth=2

"
set softtabstop=2

"
set autoindent 

" Fold on syntax automagically, always
set foldmethod=syntax

" 2 lines of column for fold showing, always
set foldcolumn=2

" Cut text to clipboard 
vmap <C-x> :!pbcopy<CR>

" Copy text to clipboard
vmap <C-c> :w !pbcopy<CR><CR>

" Paste without moving the cursor
" http://stackoverflow.com/questions/1587178/paste-in-vim-without-moving-the-cursor
noremap p p`[

" -----------------------------------------------------------------------------
"  Search

"
set hlsearch

" Show the next match while entering a search
set incsearch

" Ignoring case in a pattern
set ignorecase

" Ignore case when the pattern contains lowercase letters only.
set smartcase

" Search word under cursor w/o moving to the next match
nnoremap * :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" -----------------------------------------------------------------------------
"  Misc

" (http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file)
if has('gui_running')                  " M ~ ALT | D ~ Cmd
  set macmeta
endif

set wildmode=longest,list,full

"
set wildmenu

"
set wildignore+=*/target/*

"
set spelllang=en

"
set spellfile=$HOME/.vim/spell/en.utf-8.add

"
:command! FullPath echo expand('%:p')
"==============================================================================
"
set backup

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Show the cursor position all the time
set ruler

"
set confirm

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Keep 50 lines of command line history
set history=50

onoremap <silent> <expr> j ScreenMovement("j")
onoremap <silent> <expr> k ScreenMovement("k")
onoremap <silent> <expr> 0 ScreenMovement("0")
onoremap <silent> <expr> ^ ScreenMovement("^")
onoremap <silent> <expr> $ ScreenMovement("$")
nnoremap <silent> <expr> j ScreenMovement("j")
nnoremap <silent> <expr> k ScreenMovement("k")
nnoremap <silent> <expr> 0 ScreenMovement("0")
nnoremap <silent> <expr> ^ ScreenMovement("^")
nnoremap <silent> <expr> $ ScreenMovement("$")


" XXX Refactor to `plugin` directory
"------------------------------------------------------------
" Select buffer {{{1
" 
let g:selBufDefaultSortOrder = "path"

"------------------------------------------------------------
" Tab bar layout {{{1
" http://vim.wikia.com/wiki/Show_tab_number_in_your_tab_line 
"
:hi TabLineFill ctermfg=Black ctermbg=Black
:hi TabLine ctermfg=Gray ctermbg=Black
:hi TabLineSel ctermfg=Red ctermbg=Black

:hi TabLineFill guifg=Black guibg=Black
:hi TabLine guifg=Gray guibg=Black
:hi TabLineSel guifg=Red guibg=Black

if exists("+showtabline")
  function MyTabLine()
    let s = ''
    let t = tabpagenr()
    let i = 1
    while i <= tabpagenr('$')
      let buflist = tabpagebuflist(i)
      let winnr = tabpagewinnr(i)
      let s .= '%' . i . 'T'
      let s .= (i == t ? '%1*' : '%2*')
      let s .= ' '
      let s .= i . ':'
      let s .= winnr . '/' . tabpagewinnr(i,'$')
      let s .= ' %*'
      let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
      let bufnr = buflist[winnr - 1]
      let file = bufname(bufnr)
      let buftype = getbufvar(bufnr, 'buftype')
      if buftype == 'nofile'
        if file =~ '\/.'
          let file = substitute(file, '.*\/\ze.', '', '')
        endif
      else
        let file = fnamemodify(file, ':p:t')
      endif
      if file == ''
        let file = '[No Name]'
      endif
      let s .= file
      let i = i + 1
    endwhile
    let s .= '%T%#TabLineFill#%='
    let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
    return s
  endfunction
  set stal=2
  set tabline=%!MyTabLine()
  "map    <C-Tab>    :tabnext<CR>
  "imap   <C-Tab>    <C-O>:tabnext<CR>
  "map    <C-S-Tab>  :tabprev<CR>
  "imap   <C-S-Tab>  <C-O>:tabprev<CR>
endif
"------------------------------------------------------------
" Airline options {{{1
" https://github.com/vim-airline/vim-airline 
"
"let g:airline#extensions#tabline#enabled = 1

"------------------------------------------------------------
" NERDTree options {{{1
" https://github.com/scrooloose/nerdtree 
"
nmap <leader>d :NERDTreeToggle<CR>

"
nmap <leader>f :NERDTreeFind<CR>

" Change CWD whenever the tree root is changed 
let g:NERDTreeChDirMode = 2

"------------------------------------------------------------
" CtrlP options {{{1
" http://pyjamacoder.com/2013/04/25/getting-fuzzy-with-ctrlp/ 
" 

" Eliminate clash with yankring
"let g:ctrlp_map = '<c-p>'

" Set no max file limit
"let g:ctrlp_max_files = 0

" Search from CWD
"let g:ctrlp_working_path_mode = 'rw'

"------------------------------------------------------------
" Unit options {{{1
" https://github.com/Shougo/unite.vim 
" http://bling.github.io/blog/2013/06/02/unite-dot-vim-the-plugin-you-didnt-know-you-need/
" http://usevim.com/2013/06/19/unite/

" File searching like CtrlP 
nnoremap <C-p> :Unite file_rec/async<CR>

" Content searching like ack.vim (or ag.vim)
nnoremap <space>/ :Unite grep:.<CR>

" Yank history like yankring/yankstack
"let g:unite_source_history_yank_enable = 1
"nnoremap <space>y :Unite history/yank<CR>

" Buffer switching like LustyJuggler
"nmap <leader>b :Unite -quick-match buffer<CR>

"------------------------------------------------------------
" Git {{{1
" git clone git://github.com/tpope/vim-fugitive.git

"autocmd Filetype gitcommit setlocal spell textwidth=72

" mapping to make movements operate on 1 screen line in wrap mode
function! ScreenMovement(movement)
  if &wrap
    return "g" . a:movement
  else
    return a:movement
  endif
endfunction
