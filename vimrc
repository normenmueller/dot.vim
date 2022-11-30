" Plugins {{{1
" ===============================================================
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" Visual {{{2
" ------------------------------------------
Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
" Git {{{2
" ------------------------------------------
" Plugin 'tpope/vim-fugitive'
" Navigation {{{2
" ------------------------------------------
" File / Directory {{{3 
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
" Buffer {{{3
Plugin 'qpkorr/vim-bufkill'
Plugin 'jlanzarotta/bufexplorer'
" Markup {{{2
" ------------------------------------------
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
" Development {{{2
" ------------------------------------------
" General {{{3
Plugin 'vim-syntastic/syntastic'
" LSP {{{3
Plugin 'neoclide/coc.nvim'
" Haskell {{{3
"Plugin 'Twinside/vim-hoogle'
Plugin 'Twinside/vim-haskellFold'
"Plugin 'neovimhaskell/haskell-vim'
"Plugin 'sdiehl/vim-ormolu'
Plugin 'meck/vim-brittany'
Plugin 'alx741/vim-hindent'
Plugin 'alx741/vim-stylishask'
" Scala {{{3
Plugin 'derekwyatt/vim-scala'
" XPath {{{3
"Plugin 'actionshrimp/vim-xpath'
" REST {{{3
"Plugin 'nicwest/vim-http'
" PlantUML {{{3
Plugin 'aklt/plantuml-syntax'
" General {{{2
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'

call vundle#end()

" Command alias {{{2
"

so $HOME/.vim/plugin/cmdalias.vim

" Base {{{1
" ===============================================================
filetype plugin indent on
syntax enable
" General {{{1
" ===============================================================
"set autoread                   "via vim-sensible
set encoding=utf-8
"set backspace=indent,eol,start "via vim-sensible
"set ruler                      "via vim-sensible
set showcmd
set cmdheight=2
"set laststatus=2               "via vim-sensible
set hidden
set updatetime=300
set clipboard=unnamed
set linebreak
set breakindent
let &showbreak = '↳ '
set cpo+=n
"set autoindent                 "via vim-sensible
set expandtab
"set smarttab                   "via vim-sensible
set tabstop=4
set shiftwidth=4
set softtabstop=4
set hlsearch
"set incsearch                  "via vim-sensible
set nowrapscan
" `//` Search for visually selected text
" cf. https://vim.fandom.com/wiki/Search_for_visually_selected_text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
"set wildmenu                   "via vim-sensible
set wildmode=list:longest,full
let &wildcharm = &wildchar
" http://bit.ly/2DpGoBD
cnoremap <C-j> <DOWN>
set wildignore+=*.so,*.swp,*.zip
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:conceallevel=0
" Backup {{{1
" ===============================================================
" http://bit.ly/30SBDsB
set swapfile
set directory=${HOME}/.vim/tmp/swp//

set undofile
set undodir=${HOME}/.vim/tmp/undo//

" Some LSP servers have issues with backup files
set nobackup
set nowritebackup
"set backup
"set writebackup
"set backupdir=${HOME}/.vim/tmp/backup//
"set backupskip=/tmp/*,/private/tmp/*
" Diff {{{1
" ===============================================================
set nolist
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
" https://stackoverflow.com/questions/16840433/forcing-vimdiff-to-wrap-lines
"autocmd FilterWritePre * if &diff | setlocal wrap< | endif
au VimEnter * if &diff | execute 'windo set wrap' | endif
" Convenient command to see the difference between the current buffer and the file it was loaded from, thus the changes you made.  Revert with: ":delcommand DiffOrg".
" Cf.
" - $VIMRUNTIME/defaults.vim
" - https://stackoverflow.com/questions/63104/smarter-vim-recovery
if !exists(":DiffOrg")
    command DiffOrg vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif
" https://stackoverflow.com/questions/749297/can-i-see-changes-before-i-save-my-file-in-vim
function! s:DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()
" Navigation {{{1
" ===============================================================
set mouse=
set ttymouse=
"set mouse=a
"set ttymouse=xterm2
" Inclusive movements {{{2
" ------------------------------------------
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
" Move within visual lines {{{2
" ------------------------------------------
nmap <silent> <C-k> gk
nmap <silent> <C-j> gj
" GUI (Color, Fonts, Cursor ...) {{{1
" ===============================================================
"
colorscheme default

if has('gui_running')
    "set guioptions=egmrL
    if has("gui_mac") || has("gui_macvim")
        set macmeta " Use option (alt) as meta key.
        set lines=30
        set columns=85
        set guifont=SF\ Mono\ Light:h12
    endif
else
    "let g:airline_theme='light'
    " https://stackoverflow.com/questions/16014361/how-to-set-a-custom-color-to-folded-highlighting-in-vimrc-for-use-with-putty
    hi Folded ctermbg=255
endif
" Spelling {{{1
" ===============================================================
set spelllang=en_us,de
set spellfile=$HOME/.vim/spell/nrm.utf-8.add

hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red
" Set style for gVim
hi SpellBad gui=undercurl
hi Comment cterm=italic
" Views {{{1
" ===============================================================
" Cf. http://vim.wikia.com/wiki/Make_views_automatic
set viewoptions-=options
" FileType settings {{{1
" ===============================================================
" https://www.vim.org/scripts/script.php?script_id=732
" https://www.arthurkoziel.com/setting-up-vim-for-yaml/
let folddigest_options = "vertical,flexnumwidth"
let folddigest_size = 30

autocmd FileType gitcommit setlocal spell
autocmd FileType markdown setlocal spell
autocmd FileType pandoc setlocal spell
autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
autocmd FileType json setlocal fdm=syntax
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab fdm=indent
" Plugin settings {{{1
" ===============================================================
" ctags {{{2
" ------------------------------------------
set tags=./tags,tags,../tags

command! MakeCTags !ctags -R .
command! MakeHTags !hasktags -L --ctags .

" Open tag in vertical split
" To open a tag in horizontal split use <C-W>]
" cf. http://bit.ly/305gPxX
nnoremap <C-w>v <C-w>v <C-w>l
" CtrlP {{{2
" ------------------------------------------
let g:ctrlp_working_path_mode = 0
let g:ctrlp_show_hidden = 1
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn|stack-work)$',
            \ 'file': '\~$\|\v\.(exe|so|dll|class)'
            \ }
" Pandoc {{{2
" ------------------------------------------
let g:pandoc#syntax#conceal#use = 0
" Hindent {{{2
let g:hindent_on_save = 0
" Brittany {{{2
" ------------------------------------------
let g:brittany_on_save = 0
" NERDTree {{{2
" ------------------------------------------
" http://bit.ly/30J9vIq
nmap <leader>d :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>

let g:NERDTreeChDirMode = 2
let g:NERDTreeIgnore = ['\~$']
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDSpaceDelims = 1 " NERD Commenter
" Syntastic {{{2
" ------------------------------------------
"nmap <leader>st :SyntasticToggleMode<CR>
nmap <leader>sc :SyntasticCheck<CR>
nmap <leader>sd :SyntasticSetLoclist<CR>
nmap <leader>sr :SyntasticReset<CR>
"nnoremap <leader>sN :bufdo let b:syntastic_mode="passive"<cr>
"nnoremap <leader>sY :bufdo unlet b:syntastic_mode<cr>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"set statusline+=%{FugitiveStatusline()}

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
" Table-Mode {{{2
" ------------------------------------------
let g:table_mode_corner='|'
let g:table_mode_corner_corner='|'
let g:table_mode_header_fillchar='-'

"let g:table_mode_corner='+'
"let g:table_mode_separator = '|'
"let g:table_mode_fillchar = '-'
"let g:table_mode_header_fillchar='='
"let g:table_mode_corner_corner='+'

" Open tag in vertical split
" To open a tag in horizontal split use <C-W>]
" cf. http://bit.ly/305gPxX
nnoremap <C-w>v <C-w>v <C-w>l
" Stylishask {{{2
" ------------------------------------------
let g:stylishask_on_save = 0
" Buffer kill {{{2
" ------------------------------------------
:call CmdAlias('bd', 'BD')
" Select buffer {{{2
" ------------------------------------------
"let g:selBufDefaultSortOrder = "path"
":call CmdAlias('ls', 'SelectBuf')
" Buffer explorer {{{2
" ------------------------------------------
:call CmdAlias('ls', 'BufExplorer') " - or 'BufExplorerHorizontalSplit'
" Functions {{{1
" =============================================================================
"
" #########################################################
" #  A way to remove trailing spaces "{{{2
function! RemoveTrailingSpaces()
    silent! execute '%s/\s\+$//ge'
    silent! execute 'g/\v^$\n*%$/norm! dd'
endfunction
"autocmd BufWritePre * call RemoveTrailingSpaces()

" #########################################################
" # A way to delete 'mkview' "{{{2
" # https://www.vim.org/scripts/script.php?script_id=5109
function! MyDeleteView()
    let path = fnamemodify(bufname('%'),':p')
    " vim's odd =~ escaping for /
    let path = substitute(path, '=', '==', 'g')
    if empty($HOME)
    else
        let path = substitute(path, '^'.$HOME, '\~', '')
    endif
    let path = substitute(path, '/', '=+', 'g') . '='
    " view directory
    let path = &viewdir.'/'.path
    call delete(path)
    echo "Deleted: ".path
endfunction
command Delview call MyDeleteView()
" Lower-case user commands: http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
cabbrev delview <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Delview' : 'delview')<CR>

" Miscellaneous {{{1
" =============================================================================
"

" Project specific .vimrc files.
" https://andrew.stwrt.ca/posts/project-specific-vimrc/
set exrc
set secure

" vim:fdm=marker
