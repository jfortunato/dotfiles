set nocompatible "This fixes the problem where arrow keys do not function properly on some systems.

"put any disabled plugins here (useful for debugging)
let g:pathogen_disabled = ["PIV"]
execute pathogen#infect()
syntax on  "Enables syntax highlighting for programming languages
filetype plugin indent on


set mouse=a  "Allows you to click around the text editor with your mouse to move the cursor
set showmatch "Highlights matching brackets in programming languages
set autoindent  "If you're indented, new lines will also be indented
set smartindent  "Automatically indents lines after opening a bracket in programming languages
set backspace=2  "This makes the backspace key function like it does in other programs.
set tabstop=4  "How much space Vim gives to a tab
set number  "Enables line numbering
set smarttab  "Improves tabbing
set shiftwidth=4  "Assists code formatting
set foldmethod=manual  "Lets you hide sections of code
set autoread "Automatically load a new file if changed (useful when changing git branches)
set ignorecase "case-insensitive search
set smartcase "case-sensitive search if search contains capital
set backupdir=~/.vim/.backup "use a custom directory for backup files
set directory=~/.vim/.swap "use a custom directory for swap files
set history=1000 "alot of history
set ttimeoutlen=100 "shorten key-code timeout to stop escape delay
set scrolloff=2 "keep at least 2 lines above/below the cursor
let g:DisableAutoPHPFolding = 1 "disable autofolding in PIV plugin
let php_html_in_strings = 1 "disable php syntax highlighting in strings
let html_no_rendering = 1 "disable things like underlining links
let mapleader = "," "remap leader
let delimitMate_matchpairs = "(:),[:],{:}"

"disable automatically commenting new line after a comment
autocmd FileType * setlocal comments-=:// comments+=f://

map <C-J> :bnext<CR>
map <C-K> :bprev<CR>
map <C-L> :tabn<CR>
map <C-H> :tabp<CR>

" Give a shortcut key to NERD Tree
map <F2> :NERDTreeToggle<CR>
" Give a shortcut key to Tagbar
nmap <F8> :TagbarToggle<CR>

"remap leader to switch windows instead of ctrl"
map <leader>h <C-W>h
map <leader>j <C-W>j
map <leader>k <C-W>k
map <leader>l <C-W>l

"blade echoing
imap {{ {{<space><space>}}<esc>2hi

"Setting filetypes
nnoremap <leader>ft :set filetype<cr>
nnoremap <leader>fh :set filetype=html<cr>
nnoremap <leader>fp :set filetype=php<cr>
nnoremap <leader>fj :set filetype=javascript<cr>


" Use monokai colorscheme
let g:molokai_original = 1
colorscheme molokai

if has("gui_running")
	"using gvim

	set guioptions= 	"remove all scrollbars and toolbars and stuff

	"set line number bg to match the main color
	hi LineNr guibg=#272822
else
	"using terminal
	set t_Co=256
endif
