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

Plugin 'tpope/vim-fugitive'

" File / Directory {{{2
"

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'

" Buffer {{{2
"

Plugin 'tpope/vim-surround'
Plugin 'qpkorr/vim-bufkill'
Plugin 'jlanzarotta/bufexplorer'

" Markup {{{2
"

"Plugin 'vim-pandoc/vim-pandoc'
"Plugin 'vim-pandoc/vim-pandoc-syntax'
"Plugin 'neo4j-contrib/cypher-vim-syntax'
"Plugin 'godlygeek/tabular'
"Plugin 'plasticboy/vim-markdown'

" Development {{{2
"

" General {{{3
"

Plugin 'vim-syntastic/syntastic'

" LSP {{{3
"

"Plugin 'prabirshrestha/vim-lsp'
"Plugin 'mattn/vim-lsp-settings'
Plugin 'neoclide/coc.nvim'

" Haskell {{{3
"

Plugin 'Twinside/vim-hoogle'
"Plugin 'neovimhaskell/haskell-vim'

"Plugin 'sdiehl/vim-ormolu'
Plugin 'meck/vim-brittany'
Plugin 'alx741/vim-hindent'
Plugin 'alx741/vim-stylishask'

" Scala {{{3
"

Plugin 'derekwyatt/vim-scala'

" XPath {{{3
"

"Plugin 'actionshrimp/vim-xpath'

" Window {{{2
"

"Plugin 'wesQ3/vim-windowswap'

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

"set splitbelow
"augroup qlw
"    autocmd!
"    autocmd QuickFixCmdPost [^l]* cwindow
"    autocmd QuickFixCmdPost l*    lwindow
"augroup END

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

" GUI (Color, Fonts, Cursor ...) {{{1
" ===============================================================
"
colorscheme default

if has('gui_running')
    "set guioptions=egmrL
    if has("gui_mac") || has("gui_macvim")
        " Use option (alt) as meta key.
        set macmeta
        set lines=30
        set columns=85
        "set guifont=Source\ Code\ Pro:h12
        set guifont=SF\ Mono\ Light:h12
    endif
else
    "let g:airline_theme='light'
endif

" Spelling {{{1
" ===============================================================
"

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
let g:airline_section_b=""
"let g:airline_section_b="%t"
let g:airline_section_c=""
let g:airline_section_x=""
let g:airline_section_y=""
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_enable_fugitive=1
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

set viewoptions-=options

""autocmd BufWinLeave *.* mkview
""autocmd BufWinEnter *.* silent loadview
"autocmd BufWinLeave ?* mkview
"autocmd BufWinEnter ?* silent loadview

" Folding {{{1
" ===============================================================
"
" cf. https://vim.fandom.com/wiki/Folding
"

"augroup vimrc
"  au BufReadPre * setlocal foldmethod=indent
"  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
"augroup END

" Fold digest {{{2
" ------------------------------------------
" https://www.vim.org/scripts/script.php?script_id=732
"

let folddigest_options = "vertical,flexnumwidth"
let folddigest_size = 30

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
"
let g:NERDTreeChDirMode = 2
let g:NERDTreeIgnore = ['\~$']
let g:NERDTreeAutoDeleteBuffer=1

" NERD Commenter
let g:NERDSpaceDelims = 1

" fugitive {{{2
" ------------------------------------------
" https://dpwright.com/posts/2018/04/06/graphical-log-with-vimfugitive/

command -nargs=* Glg Git --paginate lg <args>
"command -nargs=* Glg Git! log --graph --pretty=format:'\%h - (\%ad)\%d \%s <\%an>' --abbrev-commit --date=local <args>

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

" Pandoc {{{2
" ------------------------------------------
"

"let g:pandoc#folding#fdc=0

" XML {{{2
" ------------------------------------------
"

au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

" syntastic {{{2
" ------------------------------------------
"

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

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" ghcide {{{2
" ------------------------------------------
"

" with vim-lsp {{{3
" cf. https://github.com/digital-asset/ghcide#vim-lsp

"if executable('ghcide')
"    au User lsp_setup call lsp#register_server({
"                \ 'name': 'ghcide',
"                \ 'cmd': {server_info->['ghcide', '--lsp']},
"                \ 'allowlist': ['haskell'],
"                \ })
"endif
"
" mappings
" cf. https://github.com/prabirshrestha/vim-lsp#registering-servers

"function! s:on_lsp_buffer_enabled() abort
"    setlocal omnifunc=lsp#complete
"    setlocal signcolumn=yes
"    "if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
"    nmap <buffer> qd :LspDocumentDiagnostic<CR>
"    nmap <buffer> qt :LspHover<CR>
"    nmap <buffer> [d <plug>(lsp-previous-diagnostic)
"    nmap <buffer> ]d <plug>(lsp-next-diagnostic)
"
"    " refer to doc to add more commands
"endfunction
"
"augroup lsp_install
"    au!
"    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
"    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
"augroup END

"let g:lsp_signs_enabled = 1
"let g:lsp_diagnostics_enabled = 1
"let g:lsp_diagnostics_echo_cursor = 1
""let g:lsp_diagnostics_float_cursor = 1

" with coc {{{3
" http://marco-lopes.com/articles/Vim-and-Haskell-in-2019/
" https://github.com/neoclide/coc.nvim#example-vim-configuration

" cf. ~/.vim/coc-settings.json

" mappings
function! s:on_lsp_buffer_enabled() abort
    setlocal signcolumn=number
    " Some servers have issues with backup files, see #649.
    set nobackup
    set nowritebackup
    " Don't pass messages to |ins-completion-menu|.
    set shortmess+=c
    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>
    " Show all diagnostics.
    nnoremap <silent><nowait> <leader>qg :<C-u>CocList diagnostics<cr>
    " Navigate diagnostic
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)
    " GoTo
    nmap <silent> <leader>gd <Plug>(coc-definition)
    nmap <silent> <leader>gy <Plug>(coc-type-definition)
    nmap <silent> <leader>gi <Plug>(coc-implementation)
    nmap <silent> <leader>gr <Plug>(coc-references)
    " Symbol renaming
    nmap <leader>rn <Plug>(coc-rename)
    " AutoFix
    nmap <leader>qf <Plug>(coc-fix-current)
    " refer to doc at https://github.com/neoclide/coc.nvim to add more commands
endfunction

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
endfunction

augroup lsp_install
    au!
    autocmd FileType haskell call s:on_lsp_buffer_enabled()
augroup END

" hdevtools {{{2
" ------------------------------------------
"

"au FileType haskell nnoremap <buffer> qt :HdevtoolsType<CR>
"au FileType haskell nnoremap <buffer> qi :HdevtoolsInfo<CR>
"au FileType haskell nnoremap <buffer> qc :HdevtoolsClear<CR>
" au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
" au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsInfo<CR>
" au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsClear<CR>

" ormolu {{{2
" ------------------------------------------
"

"let g:ormolu_disable=1

"nnoremap tf :call RunOrmolu()<CR>

" brittany {{{2
" ------------------------------------------
"

let g:brittany_on_save = 0

" hindent {{{2
" ------------------------------------------
"

let g:hindent_on_save = 0

" stylishask {{{2
" ------------------------------------------
"

let g:stylishask_on_save = 0

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
