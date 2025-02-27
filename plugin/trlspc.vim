function! RemoveTrailingSpaces()
    let l:save_cursor = getpos(".")
    %s/\s\+$//e
    call setpos('.', l:save_cursor)
endfunction

command! RemoveTrailingSpaces call RemoveTrailingSpaces()
