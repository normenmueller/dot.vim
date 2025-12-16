" Theme presets for :ToggleTheme; each profile tells us which colorscheme,
" airline theme and manual overrides to apply. The `folded` and `terminal`
" entries override onehalf's defaults so Folded sections and terminal buffers
" look the same across environments.
let s:theme_profiles = {
      \ 'dark': {
      \   'colorscheme': 'onehalfdark',
      \   'airline': 'onehalfdark',
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
      \   'colorscheme': 'onehalflight',
      \   'airline': 'onehalflight',
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

function! tglthm#apply(mode) abort
  let l:profile = get(s:theme_profiles, a:mode, {})
  if empty(l:profile)
    return
  endif

  execute 'colorscheme ' . l:profile.colorscheme
  let g:airline_theme = l:profile.airline
  call s:apply_folded_highlight(l:profile.folded)

  if has('terminal')
    let g:terminal_ansi_colors = copy(l:profile.terminal)
  endif

  let g:tglthm_current = a:mode

  if exists(':AirlineTheme')
    execute 'AirlineTheme ' . g:airline_theme
  endif
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

function! s:apply_folded_highlight(definition) abort
  if empty(a:definition)
    return
  endif

  execute printf(
        \ 'highlight! Folded term=%s ctermbg=%s ctermfg=%s guibg=%s guifg=%s',
        \ a:definition.term,
        \ a:definition.ctermbg,
        \ a:definition.ctermfg,
        \ a:definition.guibg,
        \ a:definition.guifg
        \ )
endfunction
