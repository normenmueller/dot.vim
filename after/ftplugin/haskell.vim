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
