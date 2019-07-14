" Vundle {{{1
" ===============================================================
"
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Visual {{{2
"

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Git {{{2
"

"Plugin 'tpope/vim-fugitive'

" File / Directory {{{2
"

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'

" Buffer {{{2
"

Plugin 'tpope/vim-surround'
Plugin 'qpkorr/vim-bufkill'

" Markup {{{2
"

"Plugin 'vim-pandoc/vim-pandoc'
"Plugin 'vim-pandoc/vim-pandoc-syntax'

" Development {{{2
"

" General {{{3
"

Plugin 'vim-syntastic/syntastic'

" Haskell {{{3
"

Plugin 'bitc/vim-hdevtools'
"Plugin 'Twinside/vim-hoogle'
Plugin 'alx741/vim-hindent'
Plugin 'alx741/vim-stylishask'
"Plugin 'neovimhaskell/haskell-vim'

" Scala {{{3
"

Plugin 'derekwyatt/vim-scala'

" General {{{2
"

Plugin 'tpope/vim-sensible'

call vundle#end()

" Base {{{1
" ===============================================================
"

filetype plugin indent on
syntax enable

" General {{{1
" ===============================================================
"

" Project specific .vimrc files.
" https://andrew.stwrt.ca/posts/project-specific-vimrc/
set exrc

"set autoread                   "via vim-sensible

set encoding=utf-8

"set backspace=indent,eol,start "via vim-sensible

"set ruler                      "via vim-sensible

set showcmd
set cmdheight=2
"set laststatus=2               "via vim-sensible

set hidden

set clipboard=unnamed

set linebreak
set breakindent
let &showbreak = '↳ '
set cpo+=n

"set autoindent                 "via vim-sensible
set expandtab
"set smarttab                   "via vim-sensible
set tabstop=4
set shiftwidth=2
set softtabstop=2

set hlsearch
"set incsearch                  "via vim-sensible

"set wildmenu                   "via vim-sensible
set wildmode=list:longest,full
let &wildcharm = &wildchar
" http://bit.ly/2DpGoBD
cnoremap <C-j> <DOWN>
set wildignore+=*.so,*.swp,*.zip
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip

"set splitbelow
augroup qlw
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow
augroup END

" Backup {{{1
" ===============================================================
"
" http://bit.ly/30SBDsB

set swapfile
set directory=${HOME}/.vim/tmp/swp//

set undofile
set undodir=${HOME}/.vim/tmp/undo//

set backup
set writebackup
set backupdir=${HOME}/.vim/tmp/backup//
set backupskip=/tmp/*,/private/tmp/*

" Diff {{{1
" ===============================================================
"

set nolist
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣

" Convenient command to see the difference between the current buffer and the file it was loaded from, thus the changes you made.  Revert with: ":delcommand DiffOrg".
" Cf.
" - $VIMRUNTIME/defaults.vim
" - https://stackoverflow.com/questions/63104/smarter-vim-recovery

if !exists(":DiffOrg")
  command DiffOrg vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif

" Navigation {{{1
" ===============================================================
"

set mouse=
set ttymouse=

" Buffer switching {{{2
" ------------------------------------------
"

nnoremap <F8> :bprevious<CR>
nnoremap <F9> :bnext<CR>

" Inclusive movements {{{2
" ------------------------------------------
"

"onoremap h vh
"onoremap l vl
"onoremap b vb
"onoremap B vB
"onoremap F vF
"onoremap T vT
"onoremap ^ v^
"onoremap g^ vg^
"onoremap + v+
"onoremap g+ vg+
"onoremap ( v(
"onoremap ` v`

" Move with visual lines {{{2
" ------------------------------------------
"

"nnoremap j gj
"nnoremap k gk
"nnoremap 0 g0
"nnoremap ^ g^
"nnoremap $ g$

" Spelling {{{1
" ===============================================================
"

set spelllang=en_us,de
set spellfile=$HOME/.vim/spell/nrm.utf-8.add

"hi clear SpellBad
"hi SpellBad cterm=underline ctermfg=red
"hi Comment cterm=italic

autocmd FileType markdown setlocal spell
autocmd FileType pandoc setlocal spell
autocmd FileType gitcommit setlocal spell

" GUI (Color, Fonts, Cursor ...) {{{1
" ===============================================================
"

if has('gui_running')
  set guioptions=egmrL
  if has("gui_mac") || has("gui_macvim")
    " Use option (alt) as meta key.
    set macmeta
    set lines=30
    set columns=75
    set guifont=SF\ Mono\ Light:h12
    "set guifont=Source\ Code\ Pro\ Light:h14
  endif
else
"  let g:airline_theme='light'
  colorscheme habiLight
endif

" Airlines' tabline {{{2
" ------------------------------------------
"

" +-----------------------------------------------------------------------------+
" | A | B |                     C                            X | Y | Z |  [...] |
" +-----------------------------------------------------------------------------+
"
" A	displays the mode + additional flags like crypt/spell/paste (INSERT)
" B	VCS information (branch, hunk summary) (master)
" C	filename + read-only flag (~/.vim/vimrc RO)
" X	filetype (vim)
" Y	file encoding[fileformat] (utf-8[unix])
" Z	current position in the file
" [...]	additional sections (warning/errors/statistics) from external plugins (e.g. YCM, syntastic, ...)
let g:airline_section_b="%t"
let g:airline_section_c=""
let g:airline_section_x=""
let g:airline_section_y=""
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_enable_fugitive=0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Cursor {{{2
" ------------------------------------------
"
" http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes
"

"let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"let &t_SR = "\<Esc>]50;CursorShape=2\x7"
"let &t_EI = "\<Esc>]50;CursorShape=0\x7"

"set cursorline

" Views {{{1
" ===============================================================
"
" Cf. http://vim.wikia.com/wiki/Make_views_automatic
"

"set viewoptions-=options

"autocmd BufWinLeave *.hs mkview
"autocmd BufWinEnter *.hs silent loadview
"" autocmd BufWinLeave ?* mkview
"" autocmd BufWinEnter ?* silent loadview

" Folding {{{1
" ===============================================================
"
" cf. https://vim.fandom.com/wiki/Folding
"

"augroup vimrc
"  au BufReadPre * setlocal foldmethod=indent
"  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
"augroup END

" Windows {{{1
" ===============================================================
"

" Switching windows {{{2
" ------------------------------------------
"

"nnoremap <C-H> <C-W><C-H>
"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>

" Plugin settings {{{1
" ===============================================================
"

" Command alias {{{2
" ------------------------------------------
"

so $HOME/.vim/plugin/cmdalias.vim

" Select buffer {{{2
" ------------------------------------------
"

"let g:selBufDefaultSortOrder = "path"
":call CmdAlias('ls', 'SelectBuf')

" Buffer explorer {{{2
" ------------------------------------------
"

:call CmdAlias('ls', 'BufExplorer') " - or 'BufExplorerHorizontalSplit'

" Buffer kill {{{2
" ------------------------------------------
"

:call CmdAlias('bd', 'BD')

" Yank ring {{{2
" ------------------------------------------
"

":command! Yanks YRShow
"let g:yankring_window_use_bottom=0
"let g:yankring_manage_numbered_reg = 0
"let g:yankring_clipboard_monitor = 0
"let g:yankring_paste_check_default_buffer = 0
"let g:yankring_zap_keys = ''
"let g:yankring_paste_n_bkey = ''
"let g:yankring_paste_n_akey = ''
"let g:yankring_paste_v_key = ''
"let g:yankring_replace_n_pkey = ''
"let g:yankring_replace_n_nkey = ''
"let g:yankring_paste_v_bkey = ''
"let g:yankring_paste_v_akey = ''

" fzf {{{2
" ------------------------------------------
"

"set rtp+=/usr/local/opt/fzf
"let g:fzf_layout = { 'up': '~20%' }
"let g:fzf_buffers_jump = 1
"nnoremap <C-p> :<C-u>FZF<CR>

" vim-table-mode {{{2
" ------------------------------------------
"

"let g:table_mode_corner='+'
"let g:table_mode_corner_corner='+'
"let g:table_mode_header_fillchar='='

" netrw {{{2
" ------------------------------------------
"

" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings
"let g:netrw_banner=0        " disable annoying banner
"let g:netrw_browse_split=4  " open in prior window
"let g:netrw_altv=1          " open splits to the right
"let g:netrw_liststyle=3     " tree view
"let g:netrw_list_hide=netrw_gitignore#Hide()
"let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" CtrlP {{{2
" ------------------------------------------
"

""set runtimepath^=~/.vim/bundle/ctrlp.vim
""let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
\ 'dir':  '\v[\/]\.(git|hg|svn|stack-work)$',
\ 'file': '\~$\|\v\.(exe|so|dll|class)'
\ }

" NERD Tree options {{{2
" ------------------------------------------
" http://bit.ly/30J9vIq
"

nmap <leader>d :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>

let g:NERDTreeChDirMode = 2
let g:NERDTreeIgnore = ['\~$']

" NERD Commenter
"let g:NERDSpaceDelims = 1

" Pandoc {{{2
" ------------------------------------------
"

"let g:pandoc#folding#fdc=0

" XML {{{2
" ------------------------------------------
"

au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

" ctags {{{2
" ------------------------------------------
"

set tags=./tags,tags,../tags

command! MakeCTags !ctags -R .
command! MakeHTags !hasktags -L --ctags .

" Open tag in vertical split
" To open a tag in horizontal split use <C-W>]
" cf. http://bit.ly/305gPxX
nnoremap <C-w>v <C-w>v <C-w>l

" ale {{{2
" ------------------------------------------
"

"let b:ale_fixers = ['stylish-haskell', 'hlint']
"let b:ale_fixers = ['stylish-haskell', 'brittany', 'hlint']
"let b:ale_set_ballons = 1

"autocmd FileType haskell nnoremap <buffer> <leader>? :call ale#cursor#ShowCursorDetail()<cr>

" ghc-mod {{{2
" ------------------------------------------
"

""map <silent> ti :GhcModTypeInsert<CR>
""map <silent> ts :GhcModSplitFunCase<CR>
""map <silent> tq :GhcModType<CR>
""map <silent> te :GhcModTypeClear<CR>
"map <silent> tq :GhcModType<CR>
"map <silent> te :GhcModTypeClear<CR>
"map <silent> tc :GhcModCheck<CR>
"map <silent> ti :GhcModInfo<CR>
"map <silent> tl :GhcModLint<CR>

" vim-hdevtools {{{2
" ------------------------------------------
"

let g:hdevtools_stack = 1

au FileType haskell nnoremap <buffer> qt :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> qi :HdevtoolsInfo<CR>
au FileType haskell nnoremap <buffer> qc :HdevtoolsClear<CR>
"au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
"au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsInfo<CR>
"au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsClear<CR>

" LanguageClient-neovim {{{2
" ------------------------------------------
"
" Note: `hie` and `hie-wrapper`, respectively, must be installed.

"set runtimepath+=~/Applications/LanguageClient-neovim
"let g:LanguageClient_serverCommands = { 'haskell': ['hie-wrapper'] }
"let g:LanguageClient_rootMarkers = ['*.cabal', 'stack.yaml']

"nnoremap <F5> :call LanguageClient_contextMenu()<CR>
"map <Leader>lk :call LanguageClient#textDocument_hover()<CR>
"map <Leader>lg :call LanguageClient#textDocument_definition()<CR>
"map <Leader>lr :call LanguageClient#textDocument_rename()<CR>
"map <Leader>lf :call LanguageClient#textDocument_formatting()<CR>
"map <Leader>lb :call LanguageClient#textDocument_references()<CR>
"map <Leader>la :call LanguageClient#textDocument_codeAction()<CR>
"map <Leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>

" syntastic {{{2
" ------------------------------------------
"

map <Leader>s :SyntasticToggleMode<CR>
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

" haskellmode-vim {{{2
" ------------------------------------------
"

" stack path --compiler-exe
"
"au BufEnter *.hs compiler ghc
"let g:ghc="/Users/nrm/.stack/programs/x86_64-osx/ghc-8.0.2/bin/ghc"
"let g:haddock_browser="open"
"let g:haddock_browser_callformat="%s %s"

" haskell code formatter {{{2
" ------------------------------------------
"

" 'formatprg' is set in .vim/after/ftplugin/haskell.vim

" vim-hindent {{{3
"

let g:hindent_on_save = 0
let g:hindent_indent_size = 4
let g:hindent_line_length = 80

" vim-stylish-haskell {{{3
"

" Functions {{{1
" =============================================================================
"
function! RemoveTrailingSpaces() "{{{
  silent! execute '%s/\s\+$//ge'
  silent! execute 'g/\v^$\n*%$/norm! dd'
endfunction
autocmd BufWritePre * call RemoveTrailingSpaces()

" Miscellaneous {{{1
" =============================================================================
"

" https://andrew.stwrt.ca/posts/project-specific-vimrc/
set secure

" vim:fdm=marker
