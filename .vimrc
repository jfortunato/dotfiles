
" BASIC INITIALIZATION
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
set nocompatible " This fixes the problem where arrow keys do not function properly on some systems.
filetype off " required!
syntax on  " Enables syntax highlighting for programming languages

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()



" PLUGINS
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

Bundle 'kien/ctrlp.vim'
Bundle 'Raimondi/delimitMate'
Bundle 'tsaleh/vim-matchit'
Bundle 'gregsexton/MatchTag'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'ervandew/supertab'
Bundle 'majutsushi/tagbar'
Bundle 'joonty/vdebug'
Bundle 'tpope/vim-surround'
Bundle 'sukima/xmledit'
Bundle 'othree/html5.vim'
Bundle 'groenewege/vim-less'
Bundle 'sumpygump/php-documentor-vim'
Bundle 'xsbeats/vim-blade'
Bundle 'arnaud-lb/vim-php-namespace'
Bundle 'craigemery/vim-autotag'
Bundle 'tpope/vim-fugitive'
Bundle 'mattn/emmet-vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'bling/vim-airline'
Bundle 'edkolev/tmuxline.vim'
Bundle 'terryma/vim-multiple-cursors'

filetype plugin indent on " required





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
set number  " Enables line numbering
set smarttab  " Improves tabbing
set shiftwidth=4  " Assists code formatting
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
let php_html_in_strings = 1 " disable php syntax highlighting in strings
let html_no_rendering = 1 " disable things like underlining links
let g:netrw_liststyle = 3 " make netrw use tree file structure
let g:netrw_browse_split = 4 " act like 'P' (ie. open previous window)
let g:netrw_altv = 1


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
nnoremap <leader>fh :set filetype=html<cr>
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



" PLUGIN SETTINGS & REMAPPINGS
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=


" ----------------- Tagbar -------------------------------------------------------
" ================ Show/Hide Tagbar ==============================================
nnoremap <F8> :TagbarToggle<CR>
" --------------------------------------------------------------------------------


" ----------------- CtrlP --------------------------------------------------------
" ================ Jump To Tags/Functions ========================================
nnoremap <C-I> :CtrlPBufTag<CR>
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
" --------------------------------------------------------------------------------


" ----------------- Airline -------------------------------------------------
let g:airline#extensions#tabline#enabled = 1 "vimline display buffers
let g:airline_theme='laederon' "airline colors
let g:airline_powerline_fonts = 1 "enable patch fonts
let g:airline#extensions#tabline#left_sep = '' "triangle buffers and tabs at top of vim
let g:airline#extensions#tabline#left_alt_sep = ''
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
" --------------------------------------------------------------------------------


" ----------------- vim-php-docblock -------------------------------------------------
au BufRead,BufNewFile *.php inoremap <buffer> <leader>d :call PhpDoc()<CR>
au BufRead,BufNewFile *.php nnoremap <buffer> <leader>d :call PhpDoc()<CR>
au BufRead,BufNewFile *.php vnoremap <buffer> <leader>d :call PhpDocRange()<CR>
" --------------------------------------------------------------------------------




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



" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <leader>n :call ToggleVExplorer()<CR>
