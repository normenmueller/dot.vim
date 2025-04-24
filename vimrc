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


" Markup {{{2


Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'


" Buffers {{{2


Plug 'qpkorr/vim-bufkill'
Plug 'jlanzarotta/bufexplorer'


" Interface {{{2


Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sonph/onehalf', { 'rtp': 'vim' }


" File System {{{2


Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'


" Development {{{2


Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'npm ci'}
Plug 'liuchengxu/vista.vim'
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

autocmd FileType gitcommit setlocal spell


" Buffers {{{2


" Buffer explorer {{{3


:call CmdAlias('ls', 'BufExplorer') " - or 'BufExplorerHorizontalSplit'


" Buffer kill {{{3


:call CmdAlias('bd', 'BD')


" Markup {{{2


" XML {{{3


autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null


" JSON {{{3


autocmd FileType json setlocal fdm=syntax


" YAML {{{3


" https://www.arthurkoziel.com/setting-up-vim-for-yaml/
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab fdm=indent


" Pandoc {{{3


let g:pandoc#spell#enabled = 0
let g:pandoc#syntax#conceal#use=0
let g:pandoc#formatting#preserve_indentation = 1

autocmd FileType markdown setlocal foldcolumn=0
autocmd FileType pandoc setlocal foldcolumn=0


" Interface {{{2


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


" Folding {{{3
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



" Color & Fonts {{{3


if has("termguicolors")
  set termguicolors
endif

"colorscheme default
colorscheme onehalfdark
let g:airline_theme='onehalfdark'
"highlight! Folded term=NONE ctermbg=black ctermfg=darkgray guibg=#282c34 guifg=#5c6370

if has("gui_running")
    set guifont=Monoid-Regular:h13
endif


" File System {{{2


nnoremap <leader>it :silent !open -a /Applications/iTerm.app "`pwd`"<CR>


" CtrlP {{{3


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

let g:NERDTreeWinSize = 35
let g:NERDTreeChDirMode = 2
let g:NERDTreeQuitOnOpen = 0
let g:NERDTreeAutoDeleteBuffer=1

nmap <leader>d :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>


" Differencing {{{3


set nolist
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣

" https://stackoverflow.com/questions/16840433/forcing-vimdiff-to-wrap-lines
"autocmd FilterWritePre * if &diff | setlocal wrap< | endif
au VimEnter * if &diff | execute 'windo set wrap' | endif


" Development  {{{2


" CoC {{{3


autocmd FileType haskell let b:coc_enabled = 1

" use `<space>o` instead!
"nnoremap <leader>mt :CocList outline<CR>
" Close CoC popups
"nnoremap <silent> <M-h> :call coc#float#close_all()<CR>

" --- CoC (defaults)
" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

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

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

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
nmap <leader>cl  <Plug>(coc-codelens-action)

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

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

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

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


" ctags {{{3


set tags=./tags,tags,../tags

command! MakeCTags !ctags -R .
command! MakeHTags !hasktags -L --ctags .

" Open tag in vertical split
" To open a tag in horizontal split use <C-W>]
" cf. http://bit.ly/305gPxX
nnoremap <C-w>v <C-w>v <C-w>l


" Vista {{{3


let g:vista_sidebar_width = 35
" use `CoC` instead of `ctags`
let g:vista_default_executive = 'coc'
let g:vista_sidebar_position = "vertical topleft"
" requires universal-ctags (brew install --HEAD universal-ctags)
let g:vista_ctags_executable = '/opt/homebrew/bin/ctags'

nnoremap <leader>vt :Vista!!<CR>





" Miscellaneous {{{2 -----------------------------------------------------------


" Enable project specific .vimrc files.
" https://andrew.stwrt.ca/posts/project-specific-vimrc/
set exrc
set secure


" vim:fdm=marker
