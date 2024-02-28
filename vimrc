set nocompatible
filetype off

" Packages {{{1
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Common {{{2
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
" Visual {{{2
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'jmckiern/vim-venter'
" Markup {{{2
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
" Navigation {{{2
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'qpkorr/vim-bufkill'
Plugin 'jlanzarotta/bufexplorer'
" Development {{{2
Plugin 'neoclide/coc.nvim'
Plugin 'alx741/vim-hindent'

call vundle#end()

filetype plugin indent on
syntax enable
" Configurations {{{1 ------------------------------------------------------------
" Basics {{{2 ------------------------------------------------------------
set mouse=
set ttymouse=
set encoding=utf-8

set showcmd
set modeline
set modelines=5
set cmdheight=2

set hidden
set updatetime=300
set clipboard=unnamed

set cpo+=n
set linebreak
set breakindent
let &showbreak = '↳ '

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set hlsearch
set nowrapscan
set ignorecase
set smartcase
" `//` Search for visually selected text
" cf. https://vim.fandom.com/wiki/Search_for_visually_selected_text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

set wildmode=list:longest,full
let &wildcharm = &wildchar
" http://bit.ly/2DpGoBD
cnoremap <C-j> <DOWN>
set wildignore+=*.so,*.swp,*.zip
" Editing {{{2 ----------------------------------------------------------
" https://vim.fandom.com/wiki/Remove_unwanted_spaces
:nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
" Spelling {{{2 ----------------------------------------------------------
set spelllang=en_us,de
set spellfile=$HOME/.vim/spell/nrm.utf-8.add

hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red
" Set style for gVim
hi SpellBad gui=undercurl
hi Comment cterm=italic

autocmd FileType markdown setlocal spell
autocmd FileType pandoc setlocal spell
autocmd FileType gitcommit setlocal spell
" Navigation {{{2 --------------------------------------------------------
" Move within visual lines
nmap <silent> <C-k> gk
"nnoremap <silent> k gk
nmap <silent> <C-j> gj
"nnoremap <silent> j gj
"nnoremap <silent> 0 g0
"nnoremap <silent> $ g$
" Differencing {{{2 --------------------------------------------------------------
set nolist
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣

" https://stackoverflow.com/questions/16840433/forcing-vimdiff-to-wrap-lines
"autocmd FilterWritePre * if &diff | setlocal wrap< | endif
au VimEnter * if &diff | execute 'windo set wrap' | endif
" Swap & Backup {{{2 -----------------------------------------------------
" http://bit.ly/30SBDsB
set swapfile
set directory=${HOME}/.vim/tmp/swp//
set undofile
set undodir=${HOME}/.vim/tmp/undo//

set nobackup
set nowritebackup
"set backup
"set writebackup
"set backupdir=${HOME}/.vim/tmp/backup//
"set backupskip=/tmp/*,/private/tmp/*
" GUI {{{2 ---------------------------------------------------------------
" Color & Fonts {{{3
colorscheme default
if has('gui_running')
    "set guioptions=egmrL
    if has("gui_mac") || has("gui_macvim")
        " Use option (alt) as meta key.
        set macmeta
        set lines=30
        set columns=85
        "set guifont=Source\ Code\ Pro:h12
        "set guifont=SF\ Mono\ Light:h12
        set guifont=MesloLGS\ NF:h13
    endif
else
    "let g:airline_theme='light'
    " https://stackoverflow.com/questions/16014361/how-to-set-a-custom-color-to-folded-highlighting-in-vimrc-for-use-with-putty
    hi Folded ctermbg=255
endif
" Cursor {{{3
" http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes
"let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"let &t_SR = "\<Esc>]50;CursorShape=2\x7"
"let &t_EI = "\<Esc>]50;CursorShape=0\x7"

"set cursorline
" Views {{{2 -------------------------------------------------------------
" Cf. http://vim.wikia.com/wiki/Make_views_automatic
set viewoptions-=options
""autocmd BufWinLeave *.* mkview
""autocmd BufWinEnter *.* silent loadview
"autocmd BufWinLeave ?* mkview
"autocmd BufWinEnter ?* silent loadview
" Folding {{{2 -----------------------------------------------------------
" cf. https://vim.fandom.com/wiki/Folding
"augroup vimrc
"  au BufReadPre * setlocal foldmethod=indent
"  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
"augroup END
" https://www.vim.org/scripts/script.php?script_id=732
let folddigest_options = "vertical,flexnumwidth"
let folddigest_size = 30
" Plugin settings {{{2 ---------------------------------------------------
" Command alias {{{3
so $HOME/.vim/plugin/cmdalias.vim
" Buffer explorer {{{3
:call CmdAlias('ls', 'BufExplorer') " - or 'BufExplorerHorizontalSplit'
" Buffer kill {{{3
:call CmdAlias('bd', 'BD')
" CoC {{{3
let g:coc_start_at_startup = v:false
" netrw {{{3
" https://shapeshed.com/vim-netrw/
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings
"let g:netrw_banner=0
"let g:netrw_liststyle=3
let g:netrw_altv=1
let g:netrw_winsize = 25
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
let g:netrw_browse_split = 0
"" open files from netrw in a previous window, unless we're opening the current dir
"" https://stackoverflow.com/questions/40764442/opening-a-file-from-netrw-in-current-window
"if argv(0) ==# '.'
"    let g:netrw_browse_split = 0
"else
"    let g:netrw_browse_split = 4
"endif
nmap <leader>` :Explore<CR>
" CtrlP {{{3
""set runtimepath^=~/.vim/bundle/ctrlp.vim
""let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn|stack-work)$',
            \ 'file': '\~$\|\v\.(exe|so|dll|class)'
            \ }
" NERDTree {{{3
" http://bit.ly/30J9vIq
nmap <leader>d :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>
let g:NERDTreeChDirMode = 2
let g:NERDTreeIgnore = ['\~$']
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDSpaceDelims = 1
" ctags {{{3
set tags=./tags,tags,../tags

command! MakeCTags !ctags -R .
command! MakeHTags !hasktags -L --ctags .

" Open tag in vertical split
" To open a tag in horizontal split use <C-W>]
" cf. http://bit.ly/305gPxX
nnoremap <C-w>v <C-w>v <C-w>l
" JSON {{{3
autocmd FileType json setlocal fdm=syntax
" YAML {{{3
" https://www.arthurkoziel.com/setting-up-vim-for-yaml/
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab fdm=indent
" XML {{{3
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
" Pandoc {{{3
let g:pandoc#syntax#conceal#use=0
" Miscellaneous {{{2 -----------------------------------------------------
" Enable project specific .vimrc files.
" https://andrew.stwrt.ca/posts/project-specific-vimrc/
set exrc
set secure

" vim:fdm=marker
