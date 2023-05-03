" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid, when inside an event handler
" (happens when dropping a file on gvim) and for a commit message (it's
" likely a different one than last time).
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

if has('persistent_undo')
  set undofile	" keep an undo file (undo changes after closing)
  set undodir=/tmp/vimbk/ " where to save undo histories, BinLi
  set undolevels=100    " How many undos, BinLi
  set undoreload=100    " number of lines to save for undo, BinLi
endif
