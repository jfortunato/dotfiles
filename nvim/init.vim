" Keeping some configs as vimscript instead of lua so that it remains compatible with IdeaVim
source ~/.config/nvim/options.vim
source ~/.config/nvim/autocmds.vim
source ~/.config/nvim/keymaps.vim
lua require('config.plugins')
lua require('config.theme')
lua require('init')
