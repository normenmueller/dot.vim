" Cf. https://wiki.haskell.org/Programming_guidelines
" Cf. https://github.com/tibbe/haskell-style-guide/blob/master/haskell-style.md
setlocal textwidth=80
setlocal colorcolumn=80

" Note: 'tabstop' should be aligned w/ 'hdevtools' 'tabstop'.
"   Cf.  `:help syntastic-checkers` | `syntastic-checkers-haskell` | `hdevtools`
setlocal tabstop=4         "A <Tab> character is 4 spaces
setlocal expandtab         "Always uses spaces instead of tabs
setlocal softtabstop=4     "Insert 2 or 4 spaces when tab is pressed
setlocal shiftwidth=4      "An indent is 2 or 4 spaces
setlocal shiftround        "Round indent to nearest shiftwidth multiple

" Formatter: manual, stylish-haskell, floskell
"setlocal formatprg=
"setlocal formatprg=hindent
nmap g= :Hindent<CR>

" hindet
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
