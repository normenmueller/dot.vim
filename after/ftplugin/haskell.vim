" Cf. https://wiki.haskell.org/Programming_guidelines
" Cf. https://github.com/tibbe/haskell-style-guide/blob/master/haskell-style.md
setlocal textwidth=80
setlocal colorcolumn=80

setlocal tabstop=4         "A <Tab> character is 4 spaces
setlocal expandtab         "Always uses spaces instead of tabs
setlocal softtabstop=4     "Insert 2 or 4 spaces when tab is pressed
setlocal shiftwidth=4      "An indent is 2 or 4 spaces
setlocal shiftround        "Round indent to nearest shiftwidth multiple

"setlocal fdm=manual
setlocal formatprg=stylish-haskell
"setlocal formatprg=hindent
"setlocal formatprg=floskell

" ale
let b:ale_fixers = ['stylish-haskell', 'hlint']
"let b:ale_fixers = ['stylish-haskell', 'brittany', 'hlint']
let b:ale_set_ballons = 1
"autocmd FileType haskell nnoremap <buffer> <leader>? :call ale#cursor#ShowCursorDetail()<cr>

" ghc-mod
"map <silent> ti :GhcModTypeInsert<CR>
"map <silent> ts :GhcModSplitFunCase<CR>
"map <silent> tq :GhcModType<CR>
"map <silent> te :GhcModTypeClear<CR>

" Hindet
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
