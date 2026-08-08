let s:config_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let s:profile_file = s:config_dir . '/profile.local.vim'

if !exists('g:vim_profile')
  let g:vim_profile = 'legacy'
endif

if filereadable(s:profile_file)
  execute 'source ' . fnameescape(s:profile_file)
endif

if !empty($VIM_PROFILE)
  let g:vim_profile = $VIM_PROFILE
endif

let s:profile_files = globpath(s:config_dir . '/profiles', '*.vim', 0, 1)
let s:valid_profiles = map(s:profile_files, 'fnamemodify(v:val, ":t:r")')
if index(s:valid_profiles, g:vim_profile) < 0
  throw 'Unknown Vim profile: ' . string(g:vim_profile)
endif

let s:profile_config = s:config_dir . '/profiles/' . g:vim_profile . '.vim'
command! VimProfile echo g:vim_profile

let data_dir = has('nvim') ? stdpath('data') . '/site' : expand('~/.vim')
let plug_file = data_dir . '/autoload/plug.vim'

if empty(glob(plug_file))
  echo "Installing vim-plug..."
  if !executable('curl')
    throw 'Cannot install vim-plug: curl is not available'
  endif
  let s:plug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  silent execute '!curl -fLo ' . shellescape(plug_file) . ' --create-dirs ' .
        \ shellescape(s:plug_url)
  if v:shell_error != 0
    throw 'Failed to install vim-plug from ' . s:plug_url
  endif
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Packages {{{1


call plug#begin()


" Common {{{2


Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Markup {{{2


Plug 'plasticboy/vim-markdown'


" Buffers {{{2


Plug 'qpkorr/vim-bufkill'


" Interface {{{2


if g:vim_profile ==# 'legacy'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'sonph/onehalf', { 'rtp': 'vim' }
  Plug 'scrooloose/nerdtree'
elseif g:vim_profile ==# 'lightline'
  Plug 'itchyny/lightline.vim'
  Plug 'sonph/onehalf', { 'rtp': 'vim' }
  Plug 'scrooloose/nerdtree'
elseif g:vim_profile ==# 'crafted'
  Plug 'sonph/onehalf', { 'rtp': 'vim' }
  Plug 'scrooloose/nerdtree'
elseif g:vim_profile ==# 'everforest'
  Plug 'itchyny/lightline.vim'
  Plug 'sainnhe/everforest'
elseif g:vim_profile ==# 'zenbones'
  Plug 'itchyny/lightline.vim'
  Plug 'zenbones-theme/zenbones.nvim'
endif


" Development {{{2


Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'npm ci'}
Plug 'alx741/vim-hindent'


call plug#end()


" Configurations {{{1


" CmdAlias is used below before Vim's normal plugin pass runs.
runtime plugin/cmdalias.vim

execute 'source ' . fnameescape(s:profile_config)


" Sets the $PATH in Vim from a saved file, which contains the correct PATH
" from the zsh shell (eg., via `echo $PATH > ~/.zsh_path` in your `.zshrc`).
" This ensures that MacVim uses the same PATH as the terminal.
let s:zsh_path_file = expand('~/.zsh_path')
if filereadable(s:zsh_path_file)
  let s:zsh_path = readfile(s:zsh_path_file, '', 1)
  if !empty(s:zsh_path) && !empty(trim(s:zsh_path[0]))
    let $PATH = trim(s:zsh_path[0])
  endif
endif
unlet s:zsh_path_file
if exists('s:zsh_path')
  unlet s:zsh_path
endif


" Basics {{{2


set updatetime=300
set encoding=utf-8

set showcmd
set cmdheight=2

set belloff=all

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

" Move within visual lines
nmap <silent> <C-k> gk
nmap <silent> <C-j> gj

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

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

" Cf. http://vim.wikia.com/wiki/Make_views_automatic
set viewoptions-=options

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
"set backupdir=${HOME}/.vim/tmp/backup//
"set backupskip=/tmp/*,/private/tmp/*

set spelllang=en_us
set spellfile=$HOME/.vim/spell/en_us.utf-8.add

hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red
hi SpellBad gui=undercurl
hi Comment cterm=italic

augroup my_spell
  autocmd!
  autocmd FileType gitcommit setlocal spell
augroup END


" Commons {{{2


" fzf {{{3


let g:fzf_preview_window = []
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:false, 'yoffset': -2.0 } }

"nnoremap <C-O> :Buffers<CR>
nnoremap <C-P> :Files<CR>
:call CmdAlias('ls', 'Buffers')


" Markup {{{2


" XML {{{3


augroup my_filetypes
  autocmd!
  autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null


" JSON {{{3


  autocmd FileType json setlocal fdm=syntax


" YAML {{{3


" https://www.arthurkoziel.com/setting-up-vim-for-yaml/
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab fdm=indent
augroup END


" Markdown {{{3


let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_folding_level = 2
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0


" Buffers {{{2


" Buffer kill {{{3


:call CmdAlias('bd', 'BD')


" Interface {{{2

" UI {{{3


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


" Color & Fonts {{{3


if has("termguicolors")
  set termguicolors
endif

if has("gui_running")
  "set guifont=Monoid-Regular:h11
  set guifont=Monoid\ Nerd\ Font\ Mono:h12
endif

let s:initial_theme = &background ==# 'light' ? 'light' : 'dark'
if has('macunix')
  let s:interface_style = system('defaults read -g AppleInterfaceStyle 2>/dev/null')
  let s:initial_theme = match(s:interface_style, 'Dark') >= 0 ? 'dark' : 'light'
  unlet s:interface_style
endif
call tglthm#apply(s:initial_theme)


" Differencing {{{3


set nolist
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣

" https://stackoverflow.com/questions/16840433/forcing-vimdiff-to-wrap-lines
"autocmd FilterWritePre * if &diff | setlocal wrap< | endif
augroup my_diff
  autocmd!
  autocmd VimEnter * if &diff | execute 'windo set wrap' | endif
augroup END


" Development  {{{2


" Coc {{{3


" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes


" Completion {{{4


" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion. Abort with <c-e>.
inoremap <silent><expr> <c-space> coc#refresh()


" Diagnostic {{{4


" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)


" Navigation {{{4


" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)

" Mapping to toggle outline
nnoremap <silent><nowait> <space>o :call ToggleOutline()<CR>

function! ToggleOutline() abort
  let winid = coc#window#find('cocViewId', 'OUTLINE')
  if winid == -1
    call CocActionAsync('showOutline', 1)
  else
    call coc#window#close(winid)
  endif
endfunction


" Documentation {{{4


" Note: Use `:call coc#float#close_all()` or `:call popup_clear()` to close all popups

" Use K to show hover information
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation() abort
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif


" Visualization {{{4


" Highlight the symbol and its references when holding the cursor
augroup my_coc_highlight
  autocmd!
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

" Miscellaneous {{{4


" Symbol renaming
" Use command `:CocCommand document.renameCurrentWord`
nmap <space>rn <Plug>(coc-rename)

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR :call CocActionAsync('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c :<C-u>CocList commands<cr>
" Find symbol of current document
"nnoremap <silent><nowait> <space>o :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p :<C-u>CocListResume<CR>


" ctags {{{3


set tags=./tags,tags,../tags

command! MakeCTags !ctags -R .
command! MakeHTags !hasktags -L --ctags .

" Open tag in vertical split
" To open a tag in horizontal split use <C-W>]
" cf. http://bit.ly/305gPxX
nnoremap <C-w>v <C-w>v <C-w>l


" Miscellaneous {{{2 -----------------------------------------------------------


" Enable project specific .vimrc files.
" https://andrew.stwrt.ca/posts/project-specific-vimrc/
set exrc
set secure


" vim:fdm=marker
