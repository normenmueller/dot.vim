setlocal textwidth=80
setlocal colorcolumn=80

setlocal tabstop=8         "A <Tab> character is 8 spaces
setlocal expandtab         "Always uses spaces instead of tabs
setlocal softtabstop=2     "Insert 2 or 4 spaces when tab is pressed
setlocal shiftwidth=2      "An indent is 2 or 4 spaces
setlocal shiftround        "Round indent to nearest shiftwidth multiple

" ghc-mod
map <silent> tq :GhcModType<CR>
map <silent> te :GhcModTypeClear<CR>
map <silent> tc :GhcModCheck<CR>
map <silent> tl :GhcModLint<CR>

" haskellmode-vim
" stack path --compiler-exe
au BufEnter *.hs compiler ghc
let g:ghc="/Users/nrm/.stack/programs/x86_64-osx/ghc-8.0.2/bin/ghc"
let g:haddock_browser="open"
let g:haddock_browser_callformat="%s %s"

" vim-hindent
"setlocal formatprg=hindent
let g:hindent_on_save=0
let g:hindent_indent_size=2
let g:hindent_line_length=80
setlocal formatprg=
nmap g= :Hindent<CR>
