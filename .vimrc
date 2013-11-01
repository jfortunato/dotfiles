set nocompatible "This fixes the problem where arrow keys do not function properly on some systems.
filetype off "required!
syntax on  "Enables syntax highlighting for programming languages

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()


" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" My Bundles
Bundle 'kien/ctrlp.vim'
Bundle 'Raimondi/delimitMate'
Bundle 'tsaleh/vim-matchit'
Bundle 'gregsexton/MatchTag'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'ervandew/supertab'
Bundle 'majutsushi/tagbar'
Bundle 'joonty/vdebug'
Bundle 'tpope/vim-surround'
Bundle 'sukima/xmledit'
"Bundle 'spf13/PIV'
Bundle 'othree/html5.vim'
Bundle 'groenewege/vim-less'
Bundle 'sumpygump/php-documentor-vim'
Bundle 'xsbeats/vim-blade'
Bundle 'arnaud-lb/vim-php-namespace'
Bundle 'craigemery/vim-autotag'
Bundle 'tpope/vim-fugitive'

filetype plugin indent on "required



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
set nofoldenable " disable code folding
set keywordprg=pman "use pman for php manual pages with shift-k
let g:DisableAutoPHPFolding = 1 "disable autofolding in PIV plugin
let php_html_in_strings = 1 "disable php syntax highlighting in strings
let html_no_rendering = 1 "disable things like underlining links
let mapleader = "," "remap leader
let delimitMate_matchpairs = "(:),[:],{:}"
"let g:netrw_liststyle = 3 "make netrw use tree file structure

"disable automatically commenting new line after a comment
autocmd FileType * setlocal comments-=:// comments+=f://
"set less filetypes
autocmd BufRead,BufNewFile *.less set filetype=less

" php docblock
au BufRead,BufNewFile *.php inoremap <buffer> <leader>d :call PhpDoc()<CR>
au BufRead,BufNewFile *.php nnoremap <buffer> <leader>d :call PhpDoc()<CR>
au BufRead,BufNewFile *.php vnoremap <buffer> <leader>d :call PhpDocRange()<CR>

noremap <C-J> :bnext<CR>
noremap <C-K> :bprev<CR>
noremap <C-L> :tabn<CR>
noremap <C-H> :tabp<CR>

" Give a shortcut key to NERD Tree
nnoremap <leader>n :NERDTreeToggle<CR>
" Give a shortcut key to Tagbar
nnoremap <F8> :TagbarToggle<CR>
" Shortcut to jump to tags/functions
nnoremap <C-I> :CtrlPBufTag<CR>

" Put php docs in a new split window
source $VIMRUNTIME/ftplugin/man.vim
nnoremap K :Man --manpath=/usr/share/doc/php5-common/PEAR/pman/ <cword><cr>

"remap leader to switch windows instead of ctrl"
noremap <leader>h <C-W>h
noremap <leader>j <C-W>j
noremap <leader>k <C-W>k
noremap <leader>l <C-W>l

"blade echoing
inoremap {{ {{<space><space>}}<esc>2hi

"Setting filetypes
nnoremap <leader>ft :set filetype<cr>
nnoremap <leader>fh :set filetype=html<cr>
nnoremap <leader>fp :set filetype=php<cr>
nnoremap <leader>fb :set filetype=blade<cr>
nnoremap <leader>fj :set filetype=javascript<cr>
nnoremap <leader>fc :set filetype=css<cr>
nnoremap <leader>fl :set filetype=less<cr>

"vimdiff update
nnoremap <leader>du :diffupdate<cr>

"easier system clipboard copy/paste
noremap <leader>p "+p
noremap <leader>P "+P
noremap <leader>y "+y
noremap <leader>Y "+Y

"quickly open vimrc from any vim session
nnoremap <leader>ev :tabnew $MYVIMRC<cr>
"quickly resource vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

"auto insert php use statements (with php namespace plugin)
inoremap <Leader>u <C-O>:call PhpInsertUse()<CR>
noremap <Leader>u :call PhpInsertUse()<CR>
"auto expand fully qualified class names
inoremap <Leader>e <C-O>:call PhpExpandClass()<CR>
noremap <Leader>e :call PhpExpandClass()<CR>

" Use monokai colorscheme
let g:molokai_original = 1
colorscheme molokai

if has("gui_running")
	"using gvim

	"start fullscreen
	function! MaximizeWindow()
	  set lines=999
	  set columns=999
	endfunction
	autocmd GUIEnter * :call MaximizeWindow()	

	set guioptions= 	"remove all scrollbars and toolbars and stuff

	"set line number bg to match the main color
	hi LineNr guibg=#272822
	hi StorageClass gui=none
	
else
	"using terminal
	set t_Co=256
endif
