call nemprofile#configure_nerdtree()
call nemprofile#configure_crafted_ui()

let g:tglthm_profiles = nemprofile#theme_pair('onehalfdark', 'onehalflight')
let g:tglthm_profiles.dark.ui = {
      \ 'StatusLine': {
      \   'term': 'bold',
      \   'ctermbg': 'darkgray',
      \   'ctermfg': 'white',
      \   'guibg': '#3c424a',
      \   'guifg': '#dcdfe4'
      \ },
      \ 'StatusLineNC': {
      \   'term': 'NONE',
      \   'ctermbg': 'black',
      \   'ctermfg': 'darkgray',
      \   'guibg': '#21252b',
      \   'guifg': '#6b7280'
      \ },
      \ 'NemUIMode': {
      \   'term': 'bold',
      \   'ctermbg': 'cyan',
      \   'ctermfg': 'black',
      \   'guibg': '#56b6c2',
      \   'guifg': '#282c34'
      \ },
      \ 'NemUIAccent': {
      \   'term': 'NONE',
      \   'ctermbg': 'darkgray',
      \   'ctermfg': 'green',
      \   'guibg': '#3c424a',
      \   'guifg': '#98c379'
      \ },
      \ 'WinSeparator': {
      \   'term': 'NONE',
      \   'ctermbg': 'black',
      \   'ctermfg': 'darkgray',
      \   'guibg': '#282c34',
      \   'guifg': '#4b5263'
      \ },
      \ 'TabLineSel': {
      \   'term': 'bold',
      \   'ctermbg': 'blue',
      \   'ctermfg': 'white',
      \   'guibg': '#4078f2',
      \   'guifg': '#ffffff'
      \ },
      \ 'TabLine': {
      \   'term': 'NONE',
      \   'ctermbg': 'black',
      \   'ctermfg': 'darkgray',
      \   'guibg': '#21252b',
      \   'guifg': '#9ca3af'
      \ },
      \ 'TabLineFill': {
      \   'term': 'NONE',
      \   'ctermbg': 'black',
      \   'ctermfg': 'black',
      \   'guibg': '#181a1f',
      \   'guifg': '#181a1f'
      \ }
      \ }

let g:tglthm_profiles.light.ui = {
      \ 'StatusLine': {
      \   'term': 'bold',
      \   'ctermbg': 'lightgray',
      \   'ctermfg': 'black',
      \   'guibg': '#dbe3ee',
      \   'guifg': '#090a0b'
      \ },
      \ 'StatusLineNC': {
      \   'term': 'NONE',
      \   'ctermbg': 'white',
      \   'ctermfg': 'lightgray',
      \   'guibg': '#f0f0f0',
      \   'guifg': '#8c8f96'
      \ },
      \ 'NemUIMode': {
      \   'term': 'bold',
      \   'ctermbg': 'blue',
      \   'ctermfg': 'white',
      \   'guibg': '#4078f2',
      \   'guifg': '#ffffff'
      \ },
      \ 'NemUIAccent': {
      \   'term': 'NONE',
      \   'ctermbg': 'lightgray',
      \   'ctermfg': 'blue',
      \   'guibg': '#dbe3ee',
      \   'guifg': '#0184bc'
      \ },
      \ 'WinSeparator': {
      \   'term': 'NONE',
      \   'ctermbg': 'white',
      \   'ctermfg': 'lightgray',
      \   'guibg': '#fafafa',
      \   'guifg': '#c5ccd6'
      \ },
      \ 'TabLineSel': {
      \   'term': 'bold',
      \   'ctermbg': 'blue',
      \   'ctermfg': 'white',
      \   'guibg': '#4078f2',
      \   'guifg': '#ffffff'
      \ },
      \ 'TabLine': {
      \   'term': 'NONE',
      \   'ctermbg': 'white',
      \   'ctermfg': 'darkgray',
      \   'guibg': '#e7eaf0',
      \   'guifg': '#5f6672'
      \ },
      \ 'TabLineFill': {
      \   'term': 'NONE',
      \   'ctermbg': 'white',
      \   'ctermfg': 'white',
      \   'guibg': '#fafafa',
      \   'guifg': '#fafafa'
      \ }
      \ }
