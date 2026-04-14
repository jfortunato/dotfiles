require('config.plugins')
require('config.theme')
require('config.lsp')
require('config.nvim-cmp')

-- Start native treesitter for all filetypes
local ts_group = vim.api.nvim_create_augroup("native_treesitter", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = ts_group,
  pattern = "*",
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})

-- Filetype alias: reuse bash parser for zsh
vim.treesitter.language.register("bash", "zsh")
