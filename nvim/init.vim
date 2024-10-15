" ========
" SETTINGS
" ========
let mapleader = "," " remap leader
set undofile " Persistent undo (undo after closing then reopening a file)
set showmatch " Highlights matching brackets in programming languages
set smartindent " Automatically indents lines after opening a bracket in programming languages
set expandtab " use space chars whenever tab is pressed
set shiftwidth=4 " Assists code formatting
set number " Enables line numbering
set relativenumber " Enables relative line numbering
set clipboard+=unnamed,unnamedplus " Enables system clipboard for copy/paste with yank/p
set ignorecase " case-insensitive search
set smartcase " case-sensitive search if search contains capital
set scrolloff=2 " keep at least 2 lines above/below the cursor
set nofoldenable " disable code folding
let html_no_rendering = 1 " disable things like underlining links
autocmd VimResized * wincmd = " Evenly distribute windows when resizing. This helps when opening a maximized window while using nvim as a git difftool


" =======
" PLUGINS
" =======
" Automatically install vim-plug if it is not already installed
let data_dir = stdpath('data') . '/site'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'Raimondi/delimitMate' " Automatically adds closing brackets, quotes, etc.
Plug 'gregsexton/MatchTag' " Highlights matching HTML tags
Plug 'preservim/nerdtree' " File tree
Plug 'preservim/nerdcommenter' " Automatically use correct commenting style
Plug 'dense-analysis/ale' " Syntax checking and linting
Plug 'joonty/vdebug' " PHP debugger
Plug 'tpope/vim-surround' " Delete/change surrounding characters (eg change single quotes to double quotes with cs'")
Plug 'sheerun/vim-polyglot' " Syntax highlighting for many languages
Plug 'tpope/vim-fugitive' " Git integration
Plug 'vim-airline/vim-airline' " Fancy status bar
Plug 'vim-airline/vim-airline-themes' " Themes for airline
Plug 'mg979/vim-visual-multi' " Multiple cursors
Plug 'godlygeek/tabular' " Align text vertically
Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'} " Snippets engine
Plug 'honza/vim-snippets' " Snippets for many languages
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} " Automatic markdown preview in browser
Plug 'junegunn/fzf' " Fuzzy file finder
Plug 'junegunn/fzf.vim' " FZF integration
Plug 'github/copilot.vim' " Github Copilot integration
Plug 'majutsushi/tagbar' " Show tags/symbols for the current file in a split
call plug#end()


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


" =====
" THEME
" =====
colorscheme tomorrow_night


" ===============
" PLUGIN SETTINGS
" ===============
" Tagbar
nnoremap <F8> :TagbarToggle<CR> " Toggle Tagbar

" FZF
" Use CTRL-P to search files
nnoremap <C-P> :FZF<CR>
nnoremap <leader><tab> :History<CR>

" Airline
set noshowmode " don't show the current mode, airline will show it
let g:airline_theme='tomorrow' "airline colors
let g:airline_powerline_fonts = 1 "enable patch fonts
let g:airline#extensions#tabline#left_sep = '' "triangle buffers and tabs at top of vim
let g:airline#extensions#tabline#left_alt_sep = ''
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:Powerline_symbols = "fancy"

" Fugitive
cmap gs Git status
cmap gd Git diff
cmap gb Git blame

" Tabular
nnoremap <leader>t :Tabularize /
vnoremap <leader>t :Tabularize /

" NERDTree
nnoremap <silent> <leader>n :NERDTreeToggle<CR> " Toggle NERDTree
nnoremap <C-f> :NERDTreeFind<cr> " Find file in NERDTree

" Markdown Preview
nmap <leader>mp <Plug>MarkdownPreview

" LuaSnip
imap <silent><expr> <leader><leader> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<leader><leader>' " use leader leader to trigger snippets (only if expand or jump is possible)
lua << EOF
    require("luasnip.loaders.from_snipmate").lazy_load() -- load snipmate style snippets
EOF
