" Theme presets for :ToggleTheme. Each profile tells us which colorscheme,
" native UI highlights and terminal colors to apply.
let s:theme_profiles = {
      \ 'dark': {
      \   'colorscheme': 'onehalfdark',
      \   'folded': {
      \     'term': 'NONE',
      \     'ctermbg': 'lightgray',
      \     'ctermfg': 'darkgray',
      \     'guibg': '#3c3f44',
      \     'guifg': '#b0b0b0'
      \   },
      \   'ui': {
      \     'StatusLine': {
      \       'term': 'bold',
      \       'ctermbg': 'darkgray',
      \       'ctermfg': 'white',
      \       'guibg': '#3c424a',
      \       'guifg': '#dcdfe4'
      \     },
      \     'StatusLineNC': {
      \       'term': 'NONE',
      \       'ctermbg': 'black',
      \       'ctermfg': 'darkgray',
      \       'guibg': '#21252b',
      \       'guifg': '#6b7280'
      \     },
      \     'NemUIMode': {
      \       'term': 'bold',
      \       'ctermbg': 'cyan',
      \       'ctermfg': 'black',
      \       'guibg': '#56b6c2',
      \       'guifg': '#282c34'
      \     },
      \     'NemUIAccent': {
      \       'term': 'NONE',
      \       'ctermbg': 'darkgray',
      \       'ctermfg': 'green',
      \       'guibg': '#3c424a',
      \       'guifg': '#98c379'
      \     },
      \     'WinSeparator': {
      \       'term': 'NONE',
      \       'ctermbg': 'black',
      \       'ctermfg': 'darkgray',
      \       'guibg': '#282c34',
      \       'guifg': '#4b5263'
      \     },
      \     'TabLineSel': {
      \       'term': 'bold',
      \       'ctermbg': 'blue',
      \       'ctermfg': 'white',
      \       'guibg': '#4078f2',
      \       'guifg': '#ffffff'
      \     },
      \     'TabLine': {
      \       'term': 'NONE',
      \       'ctermbg': 'black',
      \       'ctermfg': 'darkgray',
      \       'guibg': '#21252b',
      \       'guifg': '#9ca3af'
      \     },
      \     'TabLineFill': {
      \       'term': 'NONE',
      \       'ctermbg': 'black',
      \       'ctermfg': 'black',
      \       'guibg': '#181a1f',
      \       'guifg': '#181a1f'
      \     }
      \   },
      \   'terminal': [
      \     '#282c34', '#e06c75', '#98c379', '#e5c07b',
      \     '#61afef', '#c678dd', '#56b6c2', '#dcdfe4',
      \     '#282c34', '#e06c75', '#98c379', '#e5c07b',
      \     '#61afef', '#c678dd', '#56b6c2', '#ffffff'
      \   ]
      \ },
      \ 'light': {
      \   'colorscheme': 'onehalflight',
      \   'folded': {
      \     'term': 'NONE',
      \     'ctermbg': 'white',
      \     'ctermfg': 'lightgray',
      \     'guibg': '#ffffff',
      \     'guifg': '#b0b0b0'
      \   },
      \   'ui': {
      \     'StatusLine': {
      \       'term': 'bold',
      \       'ctermbg': 'lightgray',
      \       'ctermfg': 'black',
      \       'guibg': '#dbe3ee',
      \       'guifg': '#090a0b'
      \     },
      \     'StatusLineNC': {
      \       'term': 'NONE',
      \       'ctermbg': 'white',
      \       'ctermfg': 'lightgray',
      \       'guibg': '#f0f0f0',
      \       'guifg': '#8c8f96'
      \     },
      \     'NemUIMode': {
      \       'term': 'bold',
      \       'ctermbg': 'blue',
      \       'ctermfg': 'white',
      \       'guibg': '#4078f2',
      \       'guifg': '#ffffff'
      \     },
      \     'NemUIAccent': {
      \       'term': 'NONE',
      \       'ctermbg': 'lightgray',
      \       'ctermfg': 'blue',
      \       'guibg': '#dbe3ee',
      \       'guifg': '#0184bc'
      \     },
      \     'WinSeparator': {
      \       'term': 'NONE',
      \       'ctermbg': 'white',
      \       'ctermfg': 'lightgray',
      \       'guibg': '#fafafa',
      \       'guifg': '#c5ccd6'
      \     },
      \     'TabLineSel': {
      \       'term': 'bold',
      \       'ctermbg': 'blue',
      \       'ctermfg': 'white',
      \       'guibg': '#4078f2',
      \       'guifg': '#ffffff'
      \     },
      \     'TabLine': {
      \       'term': 'NONE',
      \       'ctermbg': 'white',
      \       'ctermfg': 'darkgray',
      \       'guibg': '#e7eaf0',
      \       'guifg': '#5f6672'
      \     },
      \     'TabLineFill': {
      \       'term': 'NONE',
      \       'ctermbg': 'white',
      \       'ctermfg': 'white',
      \       'guibg': '#fafafa',
      \       'guifg': '#fafafa'
      \     }
      \   },
      \   'terminal': [
      \     '#f0f0f0', '#e45649', '#50a14f', '#986801',
      \     '#4078f2', '#a626a4', '#0184bc', '#383a42',
      \     '#f0f0f0', '#e45649', '#50a14f', '#986801',
      \     '#4078f2', '#a626a4', '#0184bc', '#090a0b'
      \   ]
      \ }
      \ }

function! tglthm#apply(mode) abort
  let l:profile = get(s:theme_profiles, a:mode, {})
  if empty(l:profile)
    return
  endif

  execute 'colorscheme ' . l:profile.colorscheme
  call s:apply_folded_highlight(l:profile.folded)
  call s:apply_ui_highlights(l:profile.ui)

  if has('terminal')
    let g:terminal_ansi_colors = copy(l:profile.terminal)
  endif

  let g:tglthm_current = a:mode
endfunction

function! tglthm#toggle() abort
  let l:next = tglthm#resolve_mode() ==# 'dark' ? 'light' : 'dark'
  call tglthm#apply(l:next)
endfunction

function! tglthm#resolve_mode() abort
  if exists('g:tglthm_current') && type(g:tglthm_current) == type('') && !empty(g:tglthm_current)
    return g:tglthm_current
  endif

  if exists('g:colors_name')
    if g:colors_name ==# 'onehalfdark'
      return 'dark'
    elseif g:colors_name ==# 'onehalflight'
      return 'light'
    endif
  endif

  return 'dark'
endfunction

function! s:apply_ui_highlights(definitions) abort
  for l:group in keys(a:definitions)
    call s:apply_highlight(l:group, a:definitions[l:group])
  endfor

  if has_key(a:definitions, 'WinSeparator')
    call s:apply_highlight('VertSplit', a:definitions.WinSeparator)
  endif
endfunction

function! s:apply_folded_highlight(definition) abort
  if empty(a:definition)
    return
  endif

  call s:apply_highlight('Folded', a:definition)
endfunction

function! s:apply_highlight(group, definition) abort
  if empty(a:definition)
    return
  endif

  execute printf(
        \ 'highlight! %s term=%s ctermbg=%s ctermfg=%s guibg=%s guifg=%s',
        \ a:group,
        \ a:definition.term,
        \ a:definition.ctermbg,
        \ a:definition.ctermfg,
        \ a:definition.guibg,
        \ a:definition.guifg
        \ )
endfunction
