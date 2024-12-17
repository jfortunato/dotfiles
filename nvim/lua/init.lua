require("luasnip.loaders.from_snipmate").lazy_load() -- load snipmate style snippets
require("lsp") -- load lsp


-- Reserve a space in the gutter to avoid layout shift
vim.opt.signcolumn = 'yes'

-- Go to next error (only errors, not warnings). Similar to Intellij F2
-- Jump to next/previous diagnostic (errors/warnings) is already mapped to ]d and [d by default
vim.keymap.set("n", "<F2>", function ()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Jump to next error" })
