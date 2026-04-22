autocmd VimResized * wincmd = " Evenly distribute windows when resizing. This helps when opening a maximized window while using nvim as a git difftool

" Highlight all search matches while searching, then turn off highlighting when done.
" See :help incsearc for more info on this snippet
augroup vimrc-incsearch-highlight
  autocmd!
  autocmd CmdlineEnter /,\? :set hlsearch
  autocmd CmdlineLeave /,\? :set nohlsearch
augroup END
