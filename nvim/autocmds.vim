autocmd VimResized * wincmd = " Evenly distribute windows when resizing. This helps when opening a maximized window while using nvim as a git difftool

" Highlight all search matches while searching, then turn off highlighting when done.
" See :help incsearc for more info on this snippet
augroup vimrc-incsearch-highlight
  autocmd!
  autocmd CmdlineEnter /,\? :set hlsearch
  autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

" Check parent directories to determine if we are in a Hugo project
" and improve syntax highlighting for Go HTML templates
function! DetectGoHtmlTmpl()
    let l:current_dir = expand('%:p:h')
    while l:current_dir != '/' && l:current_dir != ''
        if !empty(glob(l:current_dir . '/hugo.{toml,yaml,json}'))
            set filetype=gotmpl
            set syntax=html
            return
        endif
        let l:current_dir = fnamemodify(l:current_dir, ':h')
    endwhile
endfunction

augroup filetypedetect
    au BufRead,BufNewFile *.html call DetectGoHtmlTmpl()
augroup END
