-- =======
-- PLUGINS
-- =======
vim.pack.add({
    'https://github.com/Raimondi/delimitMate', -- Automatically adds closing brackets, quotes, etc.
    'https://github.com/gregsexton/MatchTag', -- Highlights matching HTML tags
    'https://github.com/ryanoasis/vim-devicons', -- Icons for NERDTree
    'https://github.com/preservim/nerdtree', -- File tree
    'https://github.com/joonty/vdebug', -- PHP debugger
    'https://github.com/tpope/vim-surround', -- Delete/change surrounding characters (eg change single quotes to double quotes with cs'")
    'https://github.com/tpope/vim-fugitive', -- Git integration
    'https://github.com/mattn/emmet-vim', -- Quick html abbreviations
    'https://github.com/vim-airline/vim-airline', -- Fancy status bar
    'https://github.com/vim-airline/vim-airline-themes', -- Themes for airline
    'https://github.com/tanvirtin/monokai.nvim', -- Monokai theme for nvim
    'https://github.com/mg979/vim-visual-multi', -- Multiple cursors
    'https://github.com/godlygeek/tabular', -- Align text vertically
    { src = 'https://github.com/L3MON4D3/LuaSnip', version = vim.version.range('v2.*') }, -- Snippets engine
    'https://github.com/honza/vim-snippets', -- Snippets for many languages
    'https://github.com/ibhagwan/fzf-lua', -- FZF integration
    'https://github.com/zbirenbaum/copilot.lua', -- Github Copilot integration
    'https://github.com/majutsushi/tagbar', -- Show tags/symbols for the current file in a split
    'https://github.com/neovim/nvim-lspconfig', -- LSP configuration
    'https://github.com/j-hui/fidget.nvim', -- LSP progress notifications
    -- Completions for nvim-cmp
    'https://github.com/hrsh7th/nvim-cmp',
    'https://github.com/hrsh7th/cmp-nvim-lsp',
    'https://github.com/hrsh7th/cmp-buffer',
    'https://github.com/hrsh7th/cmp-path',
    'https://github.com/hrsh7th/cmp-cmdline',
    'https://github.com/saadparwaiz1/cmp_luasnip',
    -- End completions for nvim-cmp
})


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
