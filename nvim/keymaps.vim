" ==========
" REMAPPINGS
" ==========
" Change Buffers/Tabs
noremap <C-J> :bnext<CR>
noremap <C-K> :bprev<CR>
noremap <C-L> :tabn<CR>
noremap <C-H> :tabp<CR>

" Remap leader to switch windows instead of ctrl
noremap <leader>h <C-W>h
noremap <leader>j <C-W>j
noremap <leader>k <C-W>k
noremap <leader>l <C-W>l

" Template echoing
inoremap {{ {{<space><space>}}<esc>2hi
" For hugo templates. Avoid mapping '{{-' because it conflicts with the above mapping for '{{'
inoremap {- {{-<space><space>-}}<esc>3hi
inoremap {% {%<space><space>%}<esc>2hi

" Setting Filetypes
nnoremap <leader>ft :set filetype<cr>
nnoremap <leader>fh :set filetype=html syntax=php<cr>
nnoremap <leader>fp :set filetype=php<cr>
nnoremap <leader>fb :set filetype=blade<cr>
nnoremap <leader>fj :set filetype=javascript<cr>
nnoremap <leader>fc :set filetype=css<cr>
nnoremap <leader>fl :set filetype=less<cr>

" Vimdiff update
nnoremap <leader>du :diffupdate<cr>

" Edit/Re-source rc file
nnoremap <leader>ev :tabnew $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Forgot sudo
cmap w!! w !sudo tee > /dev/null %

" Comment with ctrl+/
nmap <C-/> gcc
vmap <C-/> gc
