set nocompatible              " be iMproved, required
filetype off                  " required

" =============================================================================
"
" Vundle
"
" =============================================================================
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" A lightweight implementation of the Emacs 'kill ring'
Plugin 'maxbrunsfeld/vim-yankstack'

" Interactive command execution in Vim.
" cd ~/.vim/bundle/vimproc.vim; make
"Plugin 'Shougo/vimproc.vim' 

" An alternative to 'kien/ctrlp.vim'
"Plugin 'Shougo/unite.vim'   
" 
"Plugin 'vim-ctrlspace/vim-ctrlspace'

" Unload, delete or wipe a buffer without closing the window or split 
" Was Plugin 'bufkill.vim'
"Plugin 'qpkorr/vim-bufkill'

" An alternative to `powerline/powerline`
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Git wrapper  
"Plugin 'tpope/vim-fugitive'

" Comment stuff out 
"Plugin 'tpope/vim-commentary'

" Defaults everyone can agree on 
Plugin 'tpope/vim-sensible'

" Quoting/parenthesizing made simple
Plugin 'tpope/vim-surround'

"Plugin 'tpope/vim-unimpaired'

"Plugin 'elzr/vim-json'

" Haskell mode
"Plugin 'dag/vim2hs'
"Plugin 'lukerandall/haskellmode-vim'
Plugin 'raichoo/haskell-vim'
Plugin 'Twinside/vim-haskellFold'

" Pandoc
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'

"Plugin 'altercation/vim-colors-solarized'

"Plugin 'will133/vim-dirdiff'

Plugin 'normenmueller/nerdtree'
Plugin 'normenmueller/vim-scala'
call vundle#end()
filetype plugin indent on 

" Set filetype stuff
filetype on
filetype indent on
filetype plugin on

syntax on

if has('gui_running')
  colorscheme atom
"else
"  colorscheme onedark
endif

set backup
set hidden
set confirm
set autochdir 
set clipboard=unnamed
set wildmode=longest,list,full
set wildignore+=*/target/*
set notimeout ttimeout ttimeoutlen=200

set guifont=Source\ Code\ Pro\ ExtraLight:h14
set guioptions=gmrL "egmrL
set showtabline=2
set number
set showcmd
set showmode
set showmatch
set linebreak
set cmdheight=2 
set visualbell
set cursorline

"set foldcolumn=2
set cpoptions=ces$
set mousehide
set expandtab
set shiftwidth=2
set softtabstop=2
set hlsearch
set ignorecase
set smartcase
" Search word under cursor w/o moving to the next match
nnoremap * :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" M ~ ALT | D ~ Cmd
" (http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file)
if has('gui_running')
  set macmeta
endif

set spelllang=en
set spellfile=$HOME/.vim/spell/en.utf-8.add

" Paste without moving the cursor
" http://stackoverflow.com/questions/1587178/paste-in-vim-without-moving-the-cursor
"noremap p p`[

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
" Tab bar layout {{{1
" http://vim.wikia.com/wiki/Show_tab_number_in_your_tab_line 
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
" Select buffer {{{1
let g:selBufDefaultSortOrder = "path"
so $HOME/.vim/plugin/cmdalias.vim 
:call CmdAlias('ls', 'SelectBuf') 

"------------------------------------------------------------
" YankStack
"nmap <leader>p <Plug>yankstack_substitute_older_paste
"nmap <leader>P <Plug>yankstack_substitute_newer_paste

"------------------------------------------------------------
" Airline options {{{1
let g:airline#extensions#tabline#enabled = 0
"let g:airline#extensions#tabline#show_tab_nr = 1
"let g:airline#extensions#tabline#tab_nr_type = 2
"let g:airline#extensions#tabline#buffer_idx_mode = 1

"------------------------------------------------------------
" NERDTree options {{{1
nmap <leader>d :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>
let g:NERDTreeChDirMode = 2

"------------------------------------------------------------
" CtrlSpace options {{{1
"nnoremap <silent><C-p> :CtrlSpace O<CR>

"------------------------------------------------------------
" CtrlP options {{{1
" Eliminate clash with yankring
"let g:ctrlp_map = '<c-p>'
" Set no max file limit
"let g:ctrlp_max_files = 0
" Search from CWD
"let g:ctrlp_working_path_mode = 'rw'

"------------------------------------------------------------
" Unit options {{{1
" File searching like CtrlP 
"nnoremap <C-p> :Unite file_rec/async<CR>
" Content searching like ack.vim (or ag.vim)
"nnoremap <space>/ :Unite grep:.<CR>
" Yank history like yankring/yankstack
"let g:unite_source_history_yank_enable = 1
"nnoremap <space>y :Unite history/yank<CR>
" Buffer switching like LustyJuggler
"nmap <leader>b :Unite -quick-match buffer<CR>
"so $HOME/.vim/plugin/cmdalias.vim 
":call CmdAlias('ls', 'Unite buffer') 
":call CmdAlias('ls', 'Unite buffer_tab') 

"------------------------------------------------------------
" Git {{{1
"autocmd Filetype gitcommit setlocal spell textwidth=72

"------------------------------------------------------------
" mapping to make movements operate on 1 screen line in wrap mode
function! ScreenMovement(movement)
  if &wrap
    return "g" . a:movement
  else
    return a:movement
  endif
endfunction
