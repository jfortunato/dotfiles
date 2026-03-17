require("luasnip.loaders.from_snipmate").lazy_load() -- load snipmate style snippets
require("lsp") -- load lsp
require("fidget").setup({}) -- LSP notifications
require("nvim-cmp") -- load nvim-cmp


-- Reserve a space in the gutter to avoid layout shift
vim.opt.signcolumn = 'yes'

-- Go to next error (only errors, not warnings). Similar to Intellij F2
-- Jump to next/previous diagnostic (errors/warnings) is already mapped to ]d and [d by default
vim.keymap.set("n", "<F2>", function ()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Jump to next error" })


--Change diagnostic symbols in the sign column (gutter)
vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.HINT] = " ",
        [vim.diagnostic.severity.INFO] = " ",
      },
      numhl = {
        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
        [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
        [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
        [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      },
    },
})

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
