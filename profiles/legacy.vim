call nemprofile#configure_nerdtree()

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_padding = 2
let g:airline#extensions#tabline#right_padding = 2
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#coc#enabled = 1

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

let g:tglthm_profiles = nemprofile#theme_pair('onehalfdark', 'onehalflight')
let g:tglthm_profiles.dark.airline = 'onehalfdark'
let g:tglthm_profiles.light.airline = 'onehalflight'
