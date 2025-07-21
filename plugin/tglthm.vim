function! ToggleTheme()
    if !exists("g:colors_name") || g:colors_name == "onehalfdark"
        colorscheme onehalflight
        let g:airline_theme='onehalflight'
        highlight! Folded term=NONE ctermbg=white ctermfg=lightgray guibg=#ffffff guifg=#b0b0b0

        if has('terminal')
          let g:terminal_ansi_colors = [
                \ '#f0f0f0', '#e45649', '#50a14f', '#986801',
                \ '#4078f2', '#a626a4', '#0184bc', '#383a42',
                \ '#f0f0f0', '#e45649', '#50a14f', '#986801',
                \ '#4078f2', '#a626a4', '#0184bc', '#090a0b'
                \ ]
        endif
    else
        colorscheme onehalfdark
        let g:airline_theme='onehalfdark'
        "highlight! Folded term=NONE ctermbg=black ctermfg=darkgray guibg=#282c34 guifg=#5c6370
        highlight! Folded term=NONE ctermbg=lightgray ctermfg=darkgray guibg=#3c3f44 guifg=#b0b0b0

        if has('terminal')
          let g:terminal_ansi_colors = [
                \ '#282c34', '#e06c75', '#98c379', '#e5c07b',
                \ '#61afef', '#c678dd', '#56b6c2', '#dcdfe4',
                \ '#282c34', '#e06c75', '#98c379', '#e5c07b',
                \ '#61afef', '#c678dd', '#56b6c2', '#ffffff'
                \ ]
        endif
    endif
    if exists(':AirlineTheme')
        execute 'AirlineTheme ' . g:airline_theme
    endif
    if g:colors_name != "onehalflight" && g:colors_name != "onehalfdark"
        doautocmd ColorScheme
    endif
endfunction

command! ToggleTheme call ToggleTheme()
