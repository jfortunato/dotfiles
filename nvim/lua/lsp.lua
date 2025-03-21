vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local fzf = require('fzf-lua')

        -- Define some key mappings for the LSP client. In addition to the mappings below, nvim lsp client provides some
        -- default mappings such as [d and ]d to jump to the next and previous diagnostic, and K to show hover information.
        -- See :help lsp-defaults for more information.


        -- Go to definition with gd. The sequence `gd` is normally a built-in vim command to go to the local definition of a symbol, but
        -- is very limited on its own so we can override it to use the LSP definition instead.
        -- This is also mapped by default to ctrl+]
        vim.keymap.set('n', 'gd', function() fzf.lsp_definitions({ jump_to_single_result = true }) end, { desc = "Go to definition" })
        vim.keymap.set('n', '<C-b>', function() fzf.lsp_definitions({ jump_to_single_result = true }) end, { desc = "Go to definition" }) -- similar to Intellij ctrl+b'
        vim.keymap.set('n', '<C-S-I>', fzf.lsp_definitions, { desc = "Quick definition" }) -- show definition, always in window. similar to Intellij ctrl+shift+i
        -- Go to declaration with gD.
        vim.keymap.set('n', 'gD', fzf.lsp_declarations, { desc = "Go to declaration" })
        -- Go to type definition with gt.
        vim.keymap.set('n', 'gt', fzf.lsp_typedefs, { desc = "Go to type definition" })
        -- Find references with gr.
        vim.keymap.set('n', 'gr', function() fzf.lsp_references({ jump_to_single_result = true, includeDeclaration = false }) end, { desc = "Go to references" })
        vim.keymap.set('n', '<C-b>', function() fzf.lsp_references({ jump_to_single_result = true, includeDeclaration = false }) end, { desc = "Go to references" }) -- similar to Intellij ctrl+b (Show usages)
        -- Find implementations with gi
        vim.keymap.set('n', 'gi', function() fzf.lsp_implementations({ jump_to_single_result = true }) end, { desc = "Go to implementations" })
        vim.keymap.set('n', '<C-a-b>', function() fzf.lsp_implementations({ jump_to_single_result = true }) end, { desc = "Go to implementations" }) -- similar to Intellij ctrl+alt+b
        -- Show potential actions for current line (similar to Intellij alt+enter)
        vim.keymap.set({ 'n', 'i' }, '<a-cr>', fzf.lsp_code_actions, { desc = "Show code actions" })


        -- Show line diagnostics automatically in hover window
        -- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#show-line-diagnostics-automatically-in-hover-window
        vim.api.nvim_create_autocmd("CursorHold", {
          buffer = bufnr,
          callback = function()
            local opts = {
              focusable = false,
              close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
              border = 'rounded',
              source = 'always',
              prefix = ' ',
              scope = 'cursor',
            }
            vim.diagnostic.open_float(nil, opts)
          end
        })
        -- Related to the above, disable virtual text
        vim.diagnostic.config({ virtual_text = false })


        -- Highlight symbol under cursor
        if client.supports_method('textDocument/documentHighlight') then
            vim.api.nvim_exec([[
                hi LspReferenceRead cterm=bold ctermbg=red guibg=Purple
                hi LspReferenceText cterm=bold ctermbg=red guibg=Purple
                hi LspReferenceWrite cterm=bold ctermbg=red guibg=Purple
            ]], false)
            vim.api.nvim_command 'autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()'
            vim.api.nvim_command 'autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()'
            vim.api.nvim_command 'autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()'
        end

        -- Stop all language servers for the current buffer. Can be re-started with :edit
        -- From :help lsp-faq
        -- - Q: How to force-reload LSP?
        -- - A: Stop all clients, then reload the buffer. >vim
        --      :lua vim.lsp.stop_client(vim.lsp.get_clients())
        --      :edit
        vim.api.nvim_create_user_command('LspStop', function(info)
            vim.lsp.stop_client(vim.lsp.get_clients())
        end, {
          desc = 'Stop all language servers for the current buffer',
        })
    end,
})

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require('lspconfig')

-- Function to set up LSP servers
local function setup_server(server, config)
    config = config or {}
    config.capabilities = capabilities
    lspconfig[server].setup(config)
end

-- Set up LSP servers
setup_server('gopls') -- Go
setup_server('phpactor') -- PHP
setup_server('nixd', { -- Nix
    settings = {
        nixd = {
            nixpkgs = {
                expr = "import <nixpkgs> { }",
            },
            formatting = {
                command = { "nixfmt" },
            },
            options = {
                home_manager = {
                    expr = '(builtins.getFlake "/home/justin/.dotfiles/nix").homeConfigurations.default.options',
                },
            },
        },
    },
})
