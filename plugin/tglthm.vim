if exists('g:loaded_tglthm_plugin')
  finish
endif
let g:loaded_tglthm_plugin = 1

" Thin command wrapper: all heavy lifting happens in autoload/tglthm.vim.
command! ToggleTheme call tglthm#toggle()
