function! tglthm#apply(mode) abort
  let l:profile = get(get(g:, 'tglthm_profiles', {}), a:mode, {})
  if empty(l:profile)
    return
  endif

  if has_key(l:profile, 'background')
    let &background = l:profile.background
  endif

  execute 'colorscheme ' . l:profile.colorscheme

  if has_key(l:profile, 'airline')
    let g:airline_theme = l:profile.airline
  endif

  if has_key(l:profile, 'lightline')
    let g:lightline.colorscheme = l:profile.lightline
  endif

  call s:apply_highlight('Folded', get(l:profile, 'folded', {}))
  call s:apply_ui_highlights(get(l:profile, 'ui', {}))

  if has('terminal') && has_key(l:profile, 'terminal')
    let g:terminal_ansi_colors = copy(l:profile.terminal)
  endif

  let g:tglthm_current = a:mode

  if has_key(l:profile, 'airline') && exists(':AirlineTheme')
    execute 'AirlineTheme ' . g:airline_theme
  endif

  if has_key(l:profile, 'lightline') && exists('*lightline#init')
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
  endif
endfunction

function! tglthm#toggle() abort
  let l:next = tglthm#resolve_mode() ==# 'dark' ? 'light' : 'dark'
  call tglthm#apply(l:next)
endfunction

function! tglthm#resolve_mode() abort
  if exists('g:tglthm_current')
        \ && type(g:tglthm_current) == type('')
        \ && !empty(g:tglthm_current)
    return g:tglthm_current
  endif

  if exists('g:colors_name')
    for l:mode in ['dark', 'light']
      let l:profile = get(get(g:, 'tglthm_profiles', {}), l:mode, {})
      if get(l:profile, 'colorscheme', '') !=# g:colors_name
        continue
      endif
      if !has_key(l:profile, 'background') || l:profile.background ==# &background
        return l:mode
      endif
    endfor
  endif

  return &background ==# 'light' ? 'light' : 'dark'
endfunction

function! s:apply_ui_highlights(definitions) abort
  for l:group in keys(a:definitions)
    call s:apply_highlight(l:group, a:definitions[l:group])
  endfor

  if has_key(a:definitions, 'WinSeparator')
    call s:apply_highlight('VertSplit', a:definitions.WinSeparator)
  endif
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
