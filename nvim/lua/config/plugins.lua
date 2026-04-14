-- =======
-- PLUGINS
-- =======
-- Automatically install vim-plug if it is not already installed
local data_dir = vim.fn.stdpath('data') .. '/site'
if vim.fn.empty(vim.fn.glob(data_dir .. '/autoload/plug.vim')) == 1 then
	vim.cmd('silent !curl -fLo ' ..
		data_dir ..
		'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
	vim.cmd('source ' .. data_dir .. '/autoload/plug.vim')
	vim.cmd('autocmd VimEnter * PlugInstall --sync | source $MYVIMRC')
end

local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
Plug('Raimondi/delimitMate') -- Automatically adds closing brackets, quotes, etc.
Plug('gregsexton/MatchTag') -- Highlights matching HTML tags
Plug('ryanoasis/vim-devicons') -- Icons for NERDTree
Plug('preservim/nerdtree') -- File tree
Plug('joonty/vdebug') -- PHP debugger
Plug('tpope/vim-surround') -- Delete/change surrounding characters (eg change single quotes to double quotes with cs'")
Plug('tpope/vim-fugitive') -- Git integration
Plug('mattn/emmet-vim') -- Quick html abbreviations
Plug('vim-airline/vim-airline') -- Fancy status bar
Plug('vim-airline/vim-airline-themes') -- Themes for airline
Plug('tanvirtin/monokai.nvim') -- Monokai theme for nvim
Plug('mg979/vim-visual-multi') -- Multiple cursors
Plug('godlygeek/tabular') -- Align text vertically
Plug('L3MON4D3/LuaSnip', {['tag'] = 'v2.*', ['do'] = 'make install_jsregexp'}) -- Snippets engine
Plug('honza/vim-snippets') -- Snippets for many languages
Plug('ibhagwan/fzf-lua', {['branch'] = 'main'}) -- FZF integration
Plug('zbirenbaum/copilot.lua') -- Github Copilot integration
Plug('majutsushi/tagbar') -- Show tags/symbols for the current file in a split
Plug('neovim/nvim-lspconfig') -- LSP configuration
Plug('j-hui/fidget.nvim') -- LSP progress notifications
-- Completions for nvim-cmp
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('saadparwaiz1/cmp_luasnip')
-- End completions for nvim-cmp
vim.call('plug#end')


-- ===============
-- PLUGIN SETTINGS
-- ===============
-- Tagbar
vim.keymap.set("n", "<F8>", "<cmd>TagbarToggle<cr>", { desc = "Toggle Tagbar" })

-- FZF
require'fzf-lua'.setup { fzf_opts = { ['--cycle'] = true } }
-- Use CTRL-P to search files
vim.keymap.set("n", "<C-P>", "<cmd>FzfLua files<cr>", { desc = "Search files with FZF" })
vim.keymap.set("n", "<C-E>", "<cmd>FzfLua oldfiles cwd_only=true<cr>")
vim.keymap.set("n", "<leader><tab>", "<cmd>FzfLua buffers<cr>")
vim.keymap.set("n", "<leader>m", "<cmd>FzfLua keymaps<cr>")
vim.keymap.set("n", "<leader><space>", "<cmd>FzfLua builtin<cr>")
-- Use leader + g to search git history for the current file. Use in visual mode to search to only show history for selection.
-- https://github.com/ibhagwan/fzf-lua/issues/816
vim.keymap.set("n", "<leader>g", "<cmd>FzfLua git_bcommits<cr>", { desc = "Search git history for current file with FZF" })
vim.keymap.set("x", "<leader>g", "<cmd>FzfLua git_bcommits<cr>", { desc = "Search git history for current file with FZF" })

-- Airline
vim.opt.showmode = false -- airline shows mode
vim.g.airline_theme = "tomorrow" -- airline colors
vim.g.airline_powerline_fonts = 1 -- enable patch fonts
vim.g.Powerline_symbols = "fancy"
vim.g["airline#extensions#tabline#left_sep"] = "" -- triangle buffers and tabs at top of vim
vim.g["airline#extensions#tabline#left_alt_sep"] = ""  -- triangle buffers and tabs at top of vim

-- Fugitive
vim.cmd.cnoreabbrev("gs", "Git status")
vim.cmd.cnoreabbrev("gd", "Git diff")
vim.cmd.cnoreabbrev("gb", "Git blame")

-- Tabular
vim.keymap.set("n", "<leader>t", "<cmd>Tabularize /<cr>")
vim.keymap.set("v", "<leader>t", "<cmd>Tabularize /<cr>")

-- NERDTree
vim.keymap.set("n", "<leader>n", "<cmd>NERDTreeToggle<cr>", { desc = "Toggle NERDTree" })
vim.keymap.set("n", "<C-f>", "<cmd>NERDTreeFind<cr>", { desc = "Find file in NERDTree" })

-- Emmet
vim.g.user_emmet_leader_key='<leader>' -- Use leader leader to trigger emmet

-- LuaSnip
require("luasnip.loaders.from_snipmate").lazy_load() -- load snipmate style snippets

-- Copilot setup.
require("copilot").setup({
    suggestion = {
        auto_trigger = true,
        keymap = {
            -- Accept suggestion with tab, similar to Intellij.
            accept = false,
        },
    },
    server_opts_overrides = {
        settings = {
          telemetry = { telemetryLevel = "off" },
        },
    },
})
-- Workaround for broken copilot tab accept with tab.
-- See: https://github.com/zbirenbaum/copilot.lua/issues/670
vim.keymap.set("i", "<Tab>", function()
  if require("copilot.suggestion").is_visible() then
    require("copilot.suggestion").accept()
    return "<Ignore>"
  end
  return "<Tab>"
end, { expr = true, desc = "Copilot accept or tab" })
