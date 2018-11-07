setlocal textwidth=80
setlocal colorcolumn=80

setlocal tabstop=4         "A <Tab> character is 8 spaces
setlocal expandtab         "Always uses spaces instead of tabs
setlocal softtabstop=2     "Insert 2 or 4 spaces when tab is pressed
setlocal shiftwidth=2      "An indent is 2 or 4 spaces
setlocal shiftround        "Round indent to nearest shiftwidth multiple

setlocal fdm=manual

"setlocal formatprg=stylish-haskell
"setlocal formatprg=hindent

" ghc-mod
"
"map <silent> ti :GhcModTypeInsert<CR>
"map <silent> ts :GhcModSplitFunCase<CR>
"map <silent> tq :GhcModType<CR>
"map <silent> te :GhcModTypeClear<CR>

" Hindet
"
" https://github.com/alx741/vim-hindent/blob/master/ftplugin/haskell/hindent.vim
" http://stackoverflow.com/questions/2001190/adding-a-command-to-vim
" https://goo.gl/5f9Zcw
"
"let g:hindent_indent_size=2
"let g:hindent_line_length=75

"function! s:Hindent()
"    exec "norm mz"
"    if !executable("hindent")
"        echom "Hindent not found in $PATH, did you installed it? (stack install hindent)"
"        return
"    endif
"
"    "silent! silent exec "!cat % | hindent --indent-size " &softtabstop
"    silent! silent exec "!cat % | hindent"
"    exec ':redraw!'
"
"    if v:shell_error
"        echom "Hindent: Parsing error"
"    else
"        "silent! exec "%!hindent --indent-size " &softtabstop
"        silent! exec "%!hindent"
"    endif
"    exec "norm `z"
"endfunction
"command! Hindent call s:Hindent()
