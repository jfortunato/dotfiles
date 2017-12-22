
" BASIC INITIALIZATION
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
set nocompatible " This fixes the problem where arrow keys do not function properly on some systems.
set encoding=utf-8



" PLUGINS
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

" Automatically install vim-plug if it is not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
Plug 'Raimondi/delimitMate'
Plug 'vim-scripts/matchit.zip'
Plug 'gregsexton/MatchTag'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'majutsushi/tagbar'
Plug 'joonty/vdebug'
Plug 'tpope/vim-surround'
Plug 'othree/html5.vim'
Plug 'groenewege/vim-less'
Plug 'sumpygump/php-documentor-vim'
Plug 'xsbeats/vim-blade'
Plug 'arnaud-lb/vim-php-namespace'
Plug 'tpope/vim-fugitive'
Plug 'mattn/emmet-vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'godlygeek/tabular'
" all for snipmate
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
""""""""""""""""""""
" for vim-easytags
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
"Plug 'ervandew/supertab'
Plug 'rodjek/vim-puppet'
Plug 'suan/vim-instant-markdown'
Plug 'daylerees/colour-schemes', { 'rtp': 'vim/' }
" PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run install script
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'pbogut/fzf-mru.vim'
call plug#end()





"  SETTINGS
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

" ================ Leader Key ===================================================
let mapleader = "," " remap leader


set mouse=a  " Allows you to click around the text editor with your mouse to move the cursor
set showmatch " Highlights matching brackets in programming languages
set autoindent  " If you're indented, new lines will also be indented
set smartindent  " Automatically indents lines after opening a bracket in programming languages
set backspace=2  " This makes the backspace key function like it does in other programs.
set tabstop=4  " How much space Vim gives to a tab
set expandtab " use space chars whenever tab is pressed
set shiftwidth=4  " Assists code formatting
set number  " Enables line numbering
set relativenumber  " Enables relative line numbering
set smarttab  " Improves tabbing
set foldmethod=manual  " Lets you hide sections of code
set autoread " Automatically load a new file if changed (useful when changing git branches)
set ignorecase " case-insensitive search
set smartcase " case-sensitive search if search contains capital
set history=1000 " alot of history
set ttimeoutlen=100 " shorten key-code timeout to stop escape delay
set scrolloff=2 " keep at least 2 lines above/below the cursor
set nofoldenable " disable code folding
set keywordprg=pman " use pman for php manual pages with shift-k
set laststatus=2 " always show the status line
set hidden " allow modified buffers to be hidden
set incsearch " use incremental search
set guifont=Sauce\ Code\ Powerline\ Regular\ 10
set winaltkeys=no " dont allow alt to be captured by the GUI menu entries
set tags=./tags;/
let html_no_rendering = 1 " disable things like underlining links
"let g:netrw_liststyle = 3 " make netrw use tree file structure
"let g:netrw_browse_split = 4 " act like 'P' (ie. open previous window)


" ================ Special Directories ==========================================
set backupdir=~/.vim/.backup " use a custom directory for backup files
set directory=~/.vim/.swap " use a custom directory for swap files


" ================ Persistent Undo ==============================================
" Keep undo history across sessions, by storing in file.
set undodir=~/.vim/.undo
set undofile



" ================ Automatic File Reading =======================================
autocmd FileType * setlocal comments-=:// comments+=f:// " disable automatically commenting new line after a comment
autocmd BufRead,BufNewFile *.less set filetype=less " set less filetypes
au BufRead,BufNewFile *.twig set filetype=htmljinja " syntax highlighting for twig files (.vim/after/syntax/htmljinja.vim)
au BufRead,BufNewFile *.pp set filetype=puppet
au BufRead,BufNewFile *.md set filetype=markdown



" REMAPPINGS
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

" ================ Change Buffers/Tabs ==========================================
noremap <C-J> :bnext<CR>
noremap <C-K> :bprev<CR>
noremap <C-L> :tabn<CR>
noremap <C-H> :tabp<CR>


" ================ Remap leader to switch windows instead of ctrl ===============
noremap <leader>h <C-W>h
noremap <leader>j <C-W>j
noremap <leader>k <C-W>k
noremap <leader>l <C-W>l


" ================ Blade Echoing ================================================
inoremap {{ {{<space><space>}}<esc>2hi
inoremap {% {%<space><space>%}<esc>2hi


" ================ Setting Filetypes ============================================
nnoremap <leader>ft :set filetype<cr>
nnoremap <leader>fh :set filetype=html syntax=php<cr>
nnoremap <leader>fp :set filetype=php<cr>
nnoremap <leader>fb :set filetype=blade<cr>
nnoremap <leader>fj :set filetype=javascript<cr>
nnoremap <leader>fc :set filetype=css<cr>
nnoremap <leader>fl :set filetype=less<cr>


" ================ Vimdiff Update ===============================================
nnoremap <leader>du :diffupdate<cr>


" ================ Easier System Clipboard Copy/Paste ===========================
noremap <leader>p "+p
noremap <leader>P "+P
noremap <leader>y "+y
noremap <leader>Y "+Y


" ================ Edit/Resource .vimrc =========================================
nnoremap <leader>ev :tabnew $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>


" ================ Forgot Sudo ==================================================
cmap w!! w !sudo tee > /dev/null %

" ================ Generate CTags ===============================================
nnoremap <leader>ct :! ctags -R --languages=php --exclude=.git .<cr>



" PLUGIN SETTINGS & REMAPPINGS
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=


" ----------------- Tagbar -------------------------------------------------------
" ================ Show/Hide Tagbar ==============================================
nnoremap <F8> :TagbarToggle<CR>
" --------------------------------------------------------------------------------


" ----------------- FZF ----------------------------------------------------------
" ================ Use CTRL+P for fuzzy finding ==================================
nnoremap <C-P> :FZF<CR>
nnoremap <leader><tab> :FZFMru<CR>
" --------------------------------------------------------------------------------


" ----------------- vim-php-namespace --------------------------------------------
" ================ Auto-Insert PHP Use Statements ================================
inoremap <Leader>u <C-O>:call PhpInsertUse()<CR>
noremap <Leader>u :call PhpInsertUse()<CR>
inoremap <Leader>e <C-O>:call PhpExpandClass()<CR>
noremap <Leader>e :call PhpExpandClass()<CR>
" --------------------------------------------------------------------------------

" ----------------- delimitMate -------------------------------------------------
let delimitMate_matchpairs = "(:),[:],{:}"
" --------------------------------------------------------------------------------


" ----------------- EasyMotion -------------------------------------------------
let g:EasyMotion_leader_key = '<space>' "use space for easymotion plugin
nmap s <Plug>(easymotion-s2)
" --------------------------------------------------------------------------------


" ----------------- Airline -------------------------------------------------
"let g:airline#extensions#tabline#enabled = 1 "vimline display buffers
let g:airline_theme='powerlineish' "airline colors
let g:airline_powerline_fonts = 1 "enable patch fonts
let g:airline#extensions#tabline#left_sep = '' "triangle buffers and tabs at top of vim
let g:airline#extensions#tabline#left_alt_sep = ''
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:Powerline_symbols = "fancy"
" --------------------------------------------------------------------------------

" ----------------- Tmuxline -------------------------------------------------
let g:airline#extensions#tmuxline#enabled = 1
let airline#extensions#tmuxline#snapshot_file = "~/.tmux-status.conf"
" --------------------------------------------------------------------------------


" ----------------- vim-php-docblock --------------------------------------------
au BufRead,BufNewFile *.php inoremap <buffer> <leader>d :call PhpDoc()<CR>
au BufRead,BufNewFile *.php nnoremap <buffer> <leader>d :call PhpDoc()<CR>
au BufRead,BufNewFile *.php vnoremap <buffer> <leader>d :call PhpDocRange()<CR>
" --------------------------------------------------------------------------------


" ----------------- Fugitive  ----------------------------------------------------
cmap gs Gstatus
cmap gd Gdiff
cmap gb Gblame
" --------------------------------------------------------------------------------


" ----------------- Tabularize  -------------------------------------------------
nnoremap <leader>t :Tabularize /
vnoremap <leader>t :Tabularize /
" -------------------------------------------------------------------------------


" ----------------- NERDTree  -------------------------------------------------
nnoremap <silent> <leader>n :call g:WorkaroundNERDTreeToggle()<cr>
nnoremap <C-f> :NERDTreeFind<cr>

" after deleting all buffers with wipeout function, :NERDTreeToggle bugs out
" but the first call to :NERDTree fixes everything
function! g:WorkaroundNERDTreeToggle()
  try | :NERDTreeToggle | catch | :NERDTree | endtry
endfunction
" -------------------------------------------------------------------------------

" ----------------- NERDTreeComment  -------------------------------------------------
:map <C-_> <leader>c<Space>
" -------------------------------------------------------------------------------

" ----------------- Vim-Easytags  -------------------------------------------------
let g:easytags_dynamic_files = 1
let g:easytags_auto_highlight = 0
let g:easytags_async = 1
" -------------------------------------------------------------------------------


" ----------------- Emmet  -------------------------------------------------
let g:user_emmet_leader_key='<leader>'
" -------------------------------------------------------------------------------

" ----------------- Syntastic  -------------------------------------------------
nnoremap <leader>st :SyntasticToggleMode<cr>
let g:syntastic_php_phpcs_args="--report=csv --standard=PSR2"
let g:syntastic_php_checkers = ['php', 'phpcs'] " not using phpmd right now because its too aggressive
" -------------------------------------------------------------------------------

" GUI
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

" Use monokai colorscheme
let g:molokai_original = 1
colorscheme molokai

if has("gui_running")
	" using gvim

	" start fullscreen
	function! MaximizeWindow()
	  set lines=999
	  set columns=999
	endfunction
	autocmd GUIEnter * :call MaximizeWindow()	

	set guioptions= 	" remove all scrollbars and toolbars and stuff

	" set line number bg to match the main color
    hi LineNr guibg=#272822
    hi StorageClass gui=none
else
	" using terminal
	set t_Co=256
endif





" MISC.
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

" ================ PHP Docs =====================================================
" Put php docs in a new split window
source $VIMRUNTIME/ftplugin/man.vim
nnoremap K :Man --manpath=/usr/share/doc/php5-common/PEAR/pman/ <cword><cr>


function! Wipeout()
  " list of *all* buffer numbers
  let l:buffers = range(1, bufnr('$'))

  " what tab page are we in?
  let l:currentTab = tabpagenr()
  try
	" go through all tab pages
	let l:tab = 0
	while l:tab < tabpagenr('$')
	  let l:tab += 1

	  " go through all windows
	  let l:win = 0
	  while l:win < winnr('$')
		let l:win += 1
		" whatever buffer is in this window in this tab, remove it from
		" l:buffers list
		let l:thisbuf = winbufnr(l:win)
		call remove(l:buffers, index(l:buffers, l:thisbuf))
	  endwhile
	endwhile

	" if there are any buffers left, delete them
	if len(l:buffers)
	  execute 'bwipeout' join(l:buffers)
	endif
  finally
	" go back to our original tab page
	execute 'tabnext' l:currentTab
  endtry
endfunction
map <silent> <leader>bw :call Wipeout()<cr>


function! AddPHPDependency()
    let typehint = input('TypeHint: ')
    " lowercase first letter
    let dependency = tolower(strpart(typehint, 0, 1)) . strpart(typehint, 1)
    " remove 'Interface' from ending if it exists

    :execute "normal! gg/construct\<cr>f)i, " . typehint . "\<esc>mta $" . dependency . "\<esc>/}\<cr>O$this->" . dependency . " = $" . dependency . ";\<esc>`tOprotected $" . dependency . ";\<esc>o\<esc>"

    " Remove opening comma if only one dependency
    :execute "normal! `t:s/(, /(/ge\<cr>`t"
endfunction
nmap ,2 :call AddPHPDependency()<cr>
