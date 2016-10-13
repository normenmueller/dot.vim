setlocal textwidth=80
setlocal colorcolumn=80
setlocal formatoptions=1jl
"setlocal tabstop=4
"setlocal expandtab
"setlocal softtabstop=2
"setlocal shiftwidth=2
"setlocal shiftround 
"setlocal noautoindent
"setlocal foldmethod=marker
"setlocal foldmarker=//{,//}
"setlocal foldlevel=0

" https://github.com/scrooloose/syntastic
"setlocal statusline+=%#warningmsg#
"setlocal statusline+=%{SyntasticStatuslineFlag()}
"setlocal statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 2
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0

" Syntastic & hdevtools
" Start Vim/ MacVim via `stack exec -- vim` rsp. `stack exec -- mvim`.

"let g:syntastic_haskell_hdevtools_args = '-g-isrc -g-Wall -g--package-db=$(stack path --local-pkg-db)'
"let g:hdevtools_options = '-g-isrc -g-Wall -g--package-db=$(stack path --local-pkg-db)'
"let g:syntastic_haskell_hdevtools_args = '-g-isrc -g-Wall -g--package-db=/Users/nrm/.stack/global-project/.stack-work/install/x86_64-osx/lts-7.2/8.0.1/pkgdb -g--package-db=/Users/nrm/.stack/snapshots/x86_64-osx/lts-7.2/8.0.1/pkgdb -g--package-db=/Users/nrm/.stack/global-project/.stack-work/install/x86_64-osx/lts-7.2/8.0.1/pkgdb'
"let g:syntastic_haskell_hdevtools_args = '-g-isrc -g-Wall -g--package-db=$(stack path --local-pkg-db)'
"let g:hdevtools_options = '-g-isrc -g--package-db=$(stack path --local-pkg-db)'

"let g:haskell_conceal = 0
"let g:haskell_conceal_enumerations = 0
"let g:haskell_quasi = 0
"let g:haskell_interpolation = 0
"let g:haskell_regex = 0
"let g:haskell_jmacro = 0
"let g:haskell_shqq = 0
"let g:haskell_sql = 0
"let g:haskell_json = 0
"let g:haskell_xml = 0
"let g:haskell_hsp = 0
"let g:haskell_tabular = 0

"nnoremap <leader>ht :HdevtoolsType<CR> 
"nnoremap <leader>hc :HdevtoolsClear<CR>
"au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
"au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
