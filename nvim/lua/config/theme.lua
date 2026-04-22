-- =====
-- THEME
-- =====
vim.cmd.colorscheme("tomorrow_night")
-- Fix broken status bar colors for this theme after updating nvim https://github.com/nvim-lualine/lualine.nvim/issues/1312
vim.api.nvim_set_hl(0, "StatusLine", {reverse = false})
vim.api.nvim_set_hl(0, "StatusLineNC", {reverse = false})
