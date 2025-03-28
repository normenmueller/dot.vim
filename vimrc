let data_dir = has('nvim') ? stdpath('data') . '/site' : expand('~/.vim')
let plug_file = data_dir . '/autoload/plug.vim'

if empty(glob(plug_file))
  echo "Installing vim-plug..."
  silent execute '!curl -fLo ' . plug_file . ' --create-dirs ' .
        \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Packages {{{1 ----------------------------------------------------------------


call plug#begin()


" Common {{{2


Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'


" Navigation {{{2


Plug 'ctrlpvim/ctrlp.vim'
" Alternative to CtrlP
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'qpkorr/vim-bufkill'
Plug 'jlanzarotta/bufexplorer'


" Visual {{{2


Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sonph/onehalf', { 'rtp': 'vim' }


" Markup {{{2


Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'


" Development {{{2


Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'npm ci'}
Plug 'alx741/vim-hindent'

call plug#end()


" Configurations {{{1 ----------------------------------------------------------


" Load simple plug-ins (opposed to packages)
for f in split(glob("~/.vim/plugin/*.vim"), "\n")
    try
        execute "source " . f
    catch
        echom "Error loading " . f
    endtry
endfor


" Sets the $PATH in Vim from a saved file, which contains the correct PATH
" from the zsh shell (eg., via `echo $PATH > ~/.zsh_path` in your `.zshrc`).
" This ensures that MacVim uses the same PATH as the terminal.
let $PATH = trim(readfile(expand("~/.zsh_path"))[0])


" Basics {{{2


set updatetime=300
set encoding=utf-8

set showcmd
set cmdheight=2

set modeline
set modelines=2

set hidden
set clipboard=unnamed

" By default visual line break only
set cpo+=n
set linebreak
set breakindent
let &showbreak = '↳ '
set whichwrap+=<,>,h,l

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


" Spelling {{{2 ----------------------------------------------------------------


" refactored to project local .vimrc
"set spelllang=de
"set spellfile=$HOME/.vim/spell/de.utf-8.add
"set spelllang=en_us
"set spellfile=$HOME/.vim/spell/en_us.utf-8.add

hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red
" Set style for gVim
hi SpellBad gui=undercurl
hi Comment cterm=italic

"autocmd FileType markdown setlocal spell
"autocmd FileType pandoc setlocal spell
autocmd FileType gitcommit setlocal spell


" Navigation {{{2 --------------------------------------------------------------


" Move within visual lines
nmap <silent> <C-k> gk
"nnoremap <silent> k gk
nmap <silent> <C-j> gj
"nnoremap <silent> j gj
"nnoremap <silent> 0 g0
"nnoremap <silent> $ g$


" Differencing {{{2 ------------------------------------------------------------


set nolist
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣

" https://stackoverflow.com/questions/16840433/forcing-vimdiff-to-wrap-lines
"autocmd FilterWritePre * if &diff | setlocal wrap< | endif
au VimEnter * if &diff | execute 'windo set wrap' | endif


" Swap & Backup {{{2 -----------------------------------------------------------


if !isdirectory(expand('~/.vim/tmp/swp'))
    call mkdir(expand('~/.vim/tmp/swp'), 'p')
endif

if !isdirectory(expand('~/.vim/tmp/undo'))
    call mkdir(expand('~/.vim/tmp/undo'), 'p')
endif

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


" GUI {{{2 ---------------------------------------------------------------------


" Color & Fonts {{{3


if has("termguicolors")
  set termguicolors
endif

"colorscheme default
colorscheme onehalflight
let g:airline_theme='onehalflight'
highlight! Folded term=NONE ctermbg=white ctermfg=lightgray guibg=#ffffff guifg=#b0b0b0

" XXX pretty slow :-(
"if system('osascript -e "tell application \"System Events\" to tell appearance preferences to return dark mode"') !~ "true"
"    call ToggleTheme()
"endif

if has("gui_running")
    set guifont=Monoid-Regular:h13
endif


" Cursor {{{3


" http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes
"let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"let &t_SR = "\<Esc>]50;CursorShape=2\x7"
"let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" - `guicursor`: Steuert die Cursorform in verschiedenen Modi.
" - `n-v-c:block`: Setzt im Normal-, Visual- und Command-Modus einen Block-Cursor.
" - `i-ci-ve:ver25`: Setzt im Insert-, Command-Line Insert- und
"   Visual-Exclusive-Modus einen Balken-Cursor, der 25% der Breite ausmacht.
" - `r-cr:hor20`: Im Replace- und Command-Line Replace-Modus wird ein
"   horizontaler Cursor verwendet, der 20% hoch ist.
" - `o:hor50`: Im Operator-Pending-Modus wird ein horizontaler Cursor
"   verwendet, der 50% hoch ist.
if exists('+guicursor')
    " Normal-Modus: Block-Cursor
    " Insert-Modus: Balken-Cursor
    set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
endif

" Terminal-spezifische Cursor-Einstellungen
if !has('gui_running')
    let &t_SI = "\e[6 q"   " Insert-Modus: Balken-Cursor
    let &t_SR = "\e[4 q"   " Replace-Modus: Unterstrich-Cursor
    let &t_EI = "\e[2 q"   " Normal-Modus: Block-Cursor
endif

"set cursorline


" Views {{{2 -------------------------------------------------------------------
" Cf. http://vim.wikia.com/wiki/Make_views_automatic
set viewoptions-=options
""autocmd BufWinLeave *.* mkview
""autocmd BufWinEnter *.* silent loadview
"autocmd BufWinLeave ?* mkview
"autocmd BufWinEnter ?* silent loadview


" Folding {{{2 -----------------------------------------------------------------
" cf. https://vim.fandom.com/wiki/Folding

"augroup vimrc
"  au BufReadPre * setlocal foldmethod=indent
"  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
"augroup END

"- `block`: Öffnet einen Fold, wenn du den Cursor zu einem Block {} oder einem ähnlichen Paar von Strukturblöcken (wie if/endif in manchen Sprachen) bewegst.
" - `hor`: Öffnet einen Fold, wenn du horizontal (z. B. mit <Right> oder l) in eine gefaltete Zeile hinein navigierst.
"- `mark`: Öffnet einen Fold, wenn du mit einer Markierung ('a, 'b, etc.) zu einer gefalteten Zeile springst.
"- `percent`: Öffnet einen Fold, wenn du die Prozentbewegung (%) verwendest, um zwischen passenden Klammern, Blöcken oder ähnlichen Strukturen zu springen.
"- `quickfix`: Öffnet einen Fold, wenn du mit einer Quickfix- oder Fehlerliste (:cnext, :cprev, etc.) zu einer gefalteten Zeile springst.
"- `search`: Öffnet einen Fold, wenn du durch eine Suchbewegung (/, ?, n, N) zu einer gefalteten Zeile gelangst.
"- `tag`: Öffnet einen Fold, wenn du mit :tag oder Ctrl-] zu einem Tag innerhalb eines Folds springst.
"- `undo`: Öffnet einen Fold, wenn du einen Undo-Schritt (u) ausführst, der zu einer gefalteten Zeile führt.

"set foldopen=
set foldopen-=hor

" cf. https://www.vim.org/scripts/script.php?script_id=732
let folddigest_options = "vertical,flexnumwidth,nofoldclose"
let folddigest_size = 20


" Plugin settings {{{2 ---------------------------------------------------


" Buffer explorer {{{3


:call CmdAlias('ls', 'BufExplorer') " - or 'BufExplorerHorizontalSplit'


" Buffer kill {{{3


:call CmdAlias('bd', 'BD')


" CoC {{{3


autocmd FileType haskell let b:coc_enabled = 1


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
let g:NERDTreeIgnore = ['\~$']

let g:NERDSpaceDelims = 1
let g:NERDTreeChDirMode = 2
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeAutoDeleteBuffer=1

nmap <leader>d :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>


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


autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null


" Pandoc {{{3


let g:pandoc#spell#enabled = 0
let g:pandoc#syntax#conceal#use=0
let g:pandoc#formatting#preserve_indentation = 1

autocmd FileType markdown setlocal foldcolumn=0
autocmd FileType pandoc setlocal foldcolumn=0

"augroup pandoc_settings
"  autocmd!
"  " Diese Einstellungen gelten nur für Pandoc-Dateitypen
"  autocmd FileType pandoc setlocal autoindent
"  autocmd FileType pandoc setlocal textwidth=80
"  autocmd FileType pandoc setlocal formatoptions+=t
"augroup END
"
"let g:pandoc#formatting#mode = 'h' " Hard wrapping aktivieren
"let g:pandoc#formatting#textwidth = 80 " Zeilenumbrüche nach 80 Zeichen


" Miscellaneous {{{2 -----------------------------------------------------------


" Enable project specific .vimrc files.
" https://andrew.stwrt.ca/posts/project-specific-vimrc/
set exrc
set secure


" vim:fdm=marker
