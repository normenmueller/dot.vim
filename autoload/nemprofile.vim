function! nemprofile#configure_lightline(colorscheme) abort
  set laststatus=2
  set showtabline=2
  set noshowmode

  let g:lightline = {
        \ 'colorscheme': a:colorscheme,
        \ 'active': {
        \   'left': [
        \     [ 'mode', 'paste' ],
        \     [ 'readonly', 'filename', 'modified' ]
        \   ],
        \   'right': [
        \     [ 'lineinfo' ],
        \     [ 'percent' ],
        \     [ 'fileformat', 'fileencoding', 'filetype' ],
        \     [ 'coc' ]
        \   ]
        \ },
        \ 'inactive': {
        \   'left': [ [ 'filename' ] ],
        \   'right': [ [ 'lineinfo' ], [ 'percent' ] ]
        \ },
        \ 'component': {
        \   'coc': '%{coc#status()}%{get(b:,"coc_current_function","")}'
        \ },
        \ 'separator': { 'left': '', 'right': '' },
        \ 'subseparator': { 'left': '|', 'right': '|' }
        \ }

  call s:configure_fillchars()
endfunction

function! nemprofile#configure_nerdtree() abort
  let g:NERDTreeIgnore = ['\~$']
  let g:NERDSpaceDelims = 1
  let g:NERDTreeWinSize = 30
  let g:NERDTreeChDirMode = 2
  let g:NERDTreeQuitOnOpen = 0
  let g:NERDTreeAutoDeleteBuffer = 1

  nmap <leader>d :NERDTreeToggle<CR>
  nmap <leader>f :NERDTreeFind<CR>
endfunction

function! nemprofile#configure_crafted_ui() abort
  set laststatus=2
  set showtabline=2
  set noshowmode
  set statusline=%!nemui#statusline()
  set tabline=%!nemui#tabline()

  call s:configure_fillchars()

  if has('gui_running')
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
  endif
endfunction

function! nemprofile#theme_pair(dark_colorscheme, light_colorscheme) abort
  return {
        \ 'dark': {
        \   'colorscheme': a:dark_colorscheme,
        \   'folded': {
        \     'term': 'NONE',
        \     'ctermbg': 'lightgray',
        \     'ctermfg': 'darkgray',
        \     'guibg': '#3c3f44',
        \     'guifg': '#b0b0b0'
        \   },
        \   'terminal': [
        \     '#282c34', '#e06c75', '#98c379', '#e5c07b',
        \     '#61afef', '#c678dd', '#56b6c2', '#dcdfe4',
        \     '#282c34', '#e06c75', '#98c379', '#e5c07b',
        \     '#61afef', '#c678dd', '#56b6c2', '#ffffff'
        \   ]
        \ },
        \ 'light': {
        \   'colorscheme': a:light_colorscheme,
        \   'folded': {
        \     'term': 'NONE',
        \     'ctermbg': 'white',
        \     'ctermfg': 'lightgray',
        \     'guibg': '#ffffff',
        \     'guifg': '#b0b0b0'
        \   },
        \   'terminal': [
        \     '#f0f0f0', '#e45649', '#50a14f', '#986801',
        \     '#4078f2', '#a626a4', '#0184bc', '#383a42',
        \     '#f0f0f0', '#e45649', '#50a14f', '#986801',
        \     '#4078f2', '#a626a4', '#0184bc', '#090a0b'
        \   ]
        \ }
        \ }
endfunction

function! s:configure_fillchars() abort
  if exists('+fillchars')
    set fillchars=vert:│,fold:·,diff:╱
  endif
endfunction
