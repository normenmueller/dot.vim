function! ToggleTheme()
    if !exists("g:colors_name") || g:colors_name == "onehalfdark"
        colorscheme onehalflight
        let g:airline_theme='onehalflight'
        highlight! Folded term=NONE ctermbg=white ctermfg=lightgray guibg=#ffffff guifg=#b0b0b0
    else
        colorscheme onehalfdark
        let g:airline_theme='onehalfdark'
        highlight! Folded term=NONE ctermbg=black ctermfg=darkgray guibg=#282c34 guifg=#5c6370
    endif
    if exists(':AirlineTheme')
        execute 'AirlineTheme ' . g:airline_theme
    endif
    if g:colors_name != "onehalflight" && g:colors_name != "onehalfdark"
        doautocmd ColorScheme
    endif
endfunction

command! ToggleTheme call ToggleTheme()
