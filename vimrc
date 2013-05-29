set nocompatible "This fixes the problem where arrow keys do not function properly on some systems.
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
let g:DisableAutoPHPFolding = 1 "disable autofolding in PIV plugin
let html_no_rendering = 1
let mapleader = "," "remap leader

map <C-J> :bnext<CR>
map <C-K> :bprev<CR>
map <C-L> :tabn<CR>
map <C-H> :tabp<CR>


"--- The following commands make the navigation keys work like standard editors
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk
"--- Ends navigation commands


"--- The following adds a sweet menu, press F4 to use it.
source $VIMRUNTIME/menu.vim
set wildmenu
set cpo-=<
set wcm=<C-Z>
map <F4> :emenu <C-Z>
"--- End sweet menu

" Give a shortcut key to NERD Tree
map <F2> :NERDTreeToggle<CR>

" Use monokai colorscheme
let g:molokai_original = 1
colorscheme molokai

if has("gui_running")
	"using gvim

	set guioptions-=T  "remove toolbar
	set guioptions-=r  "remove scrollbar

	"set line number bg to match the main color
	hi LineNr guibg=#272822
else
	"using terminal
	set t_Co=256
endif
