if get(g:, 'loaded_note', 0)
  finish
endif

let g:loaded_note = 1

command! -nargs=? -complete=file Note silent call note#note(<q-args>)
