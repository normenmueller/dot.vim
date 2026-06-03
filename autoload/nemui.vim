let s:mode_labels = {
      \ 'n': 'NORMAL',
      \ 'no': 'O-PENDING',
      \ 'nov': 'O-PENDING',
      \ 'noV': 'O-PENDING',
      \ 'niI': 'NORMAL',
      \ 'niR': 'NORMAL',
      \ 'niV': 'NORMAL',
      \ 'v': 'VISUAL',
      \ 'V': 'V-LINE',
      \ 's': 'SELECT',
      \ 'S': 'S-LINE',
      \ 'i': 'INSERT',
      \ 'ic': 'INSERT',
      \ 'ix': 'INSERT',
      \ 'R': 'REPLACE',
      \ 'Rc': 'REPLACE',
      \ 'Rv': 'V-REPLACE',
      \ 'Rx': 'REPLACE',
      \ 'c': 'COMMAND',
      \ 'cv': 'EX',
      \ 'ce': 'EX',
      \ 'r': 'PROMPT',
      \ 'rm': 'MORE',
      \ 'r?': 'CONFIRM',
      \ 't': 'TERMINAL',
      \ }
let s:mode_labels['no' . nr2char(22)] = 'O-PENDING'
let s:mode_labels[nr2char(22)] = 'V-BLOCK'
let s:mode_labels[nr2char(19)] = 'S-BLOCK'

function! nemui#statusline() abort
  if !s:is_active_window()
    return '%#StatusLineNC# %<%f %m%r%h%w%=%y  %l:%c '
  endif

  return '%#NemUIMode# ' . nemui#mode_label() . ' '
        \ . '%#StatusLine# %<%f %m%r%h%w'
        \ . '%=%#NemUIAccent#%{nemui#git_branch()}%{nemui#coc_status()}'
        \ . '%#StatusLine# %y  %{nemui#file_format()}  %l:%c  %p%% '
endfunction

function! nemui#tabline() abort
  let l:line = ''

  for l:tabnr in range(1, tabpagenr('$'))
    let l:buffers = tabpagebuflist(l:tabnr)
    let l:winnr = tabpagewinnr(l:tabnr)
    let l:bufnr = l:buffers[l:winnr - 1]
    let l:group = l:tabnr == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'
    let l:line .= '%' . l:tabnr . 'T' . l:group . ' '
          \ . l:tabnr . ' ' . s:tab_label(l:bufnr, l:buffers) . ' '
  endfor

  let l:line .= '%#TabLineFill#%T'
  if tabpagenr('$') > 1
    let l:line .= '%=%#TabLine# ' . tabpagenr() . '/' . tabpagenr('$') . ' '
  endif

  return l:line
endfunction

function! nemui#mode_label() abort
  return get(s:mode_labels, mode(1), get(s:mode_labels, mode(), toupper(mode())))
endfunction

function! nemui#git_branch() abort
  if exists('*FugitiveHead')
    let l:branch = FugitiveHead()
    if !empty(l:branch)
      return ' git:' . l:branch
    endif
  endif

  return ''
endfunction

function! nemui#coc_status() abort
  let l:parts = []

  if exists('*coc#status')
    let l:status = coc#status()
    if !empty(l:status)
      call add(l:parts, l:status)
    endif
  endif

  let l:function = get(b:, 'coc_current_function', '')
  if !empty(l:function)
    call add(l:parts, l:function)
  endif

  return empty(l:parts) ? '' : ' ' . join(l:parts, ' ')
endfunction

function! nemui#file_format() abort
  let l:encoding = empty(&fileencoding) ? &encoding : &fileencoding
  return l:encoding . '[' . &fileformat . ']'
endfunction

function! s:is_active_window() abort
  return !exists('g:statusline_winid') || g:statusline_winid == win_getid()
endfunction

function! s:tab_label(bufnr, buffers) abort
  let l:name = bufname(a:bufnr)
  let l:label = empty(l:name) ? '[No Name]' : fnamemodify(l:name, ':t')
  if empty(l:label)
    let l:label = fnamemodify(l:name, ':~:.')
  endif

  let l:label = s:truncate(l:label, 24)

  if s:tab_has_modified_buffer(a:buffers)
    let l:label .= '+'
  endif

  if len(a:buffers) > 1
    let l:label .= ':' . len(a:buffers)
  endif

  return l:label
endfunction

function! s:tab_has_modified_buffer(buffers) abort
  for l:bufnr in a:buffers
    if getbufvar(l:bufnr, '&modified')
      return 1
    endif
  endfor

  return 0
endfunction

function! s:truncate(text, max_width) abort
  if strdisplaywidth(a:text) <= a:max_width
    return a:text
  endif

  return strcharpart(a:text, 0, a:max_width - 3) . '...'
endfunction
