function! nemmarkdown#fold() abort
  " Vim mistakes a closing YAML frontmatter delimiter for a Setext heading.
  if v:lnum > 1
        \ && getline(1) =~# '^---\s*$'
        \ && getline(v:lnum + 1) =~# '^---\s*$'
        \ && match(getline(2, v:lnum + 1), '^---\s*$') == v:lnum - 1
    return '='
  endif

  return MarkdownFold()
endfunction
