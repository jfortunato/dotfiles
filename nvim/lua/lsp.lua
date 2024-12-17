vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        -- Define some key mappings for the LSP client. In addition to the mappings below, nvim lsp client provides some
        -- default mappings such as [d and ]d to jump to the next and previous diagnostic, and K to show hover information.
        -- See :help lsp-defaults for more information.


        -- Go to definition with gd. The sequence `gd` is normally a built-in vim command to go to the local definition of a symbol, but
        -- is very limited on its own so we can override it to use the LSP definition instead.
        -- This is also mapped by default to ctrl+]
        if client.supports_method('textDocument/definition') then
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf, desc = "Go to definition" })
            vim.keymap.set('n', '<C-b>', vim.lsp.buf.definition, { buffer = args.buf, desc = "Go to definition" }) -- similar to Intellij ctrl+b'
        end
        if client.supports_method('textDocument/declaration') then
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = args.buf })
        end
        if client.supports_method('textDocument/typeDefinition') then
            vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { buffer = args.buf })
        end
        -- Find references with gr.
        if client.supports_method('textDocument/references') then
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = args.buf, desc = "Go to references" })
            vim.keymap.set('n', '<C-b>', vim.lsp.buf.references, { buffer = args.buf, desc = "Go to references" }) -- similar to Intellij ctrl+b (Show usages)
        end
        -- Find implementations with gi
        if client.supports_method('textDocument/implementation') then
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = args.buf, desc = "Go to implementations" })
            vim.keymap.set('n', '<C-a-b>', vim.lsp.buf.implementation, { buffer = args.buf, desc = "Go to implementations" }) -- similar to Intellij ctrl+alt+b
        end
        -- Show potential actions for current line (similar to Intellij alt+enter)
        if client.supports_method('textDocument/codeAction') then
            vim.keymap.set({ 'n', 'i' }, '<a-cr>', vim.lsp.buf.code_action, { buffer = args.buf })
        end
        if client.supports_method('textDocument/signatureHelp') then
            vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { buffer = args.buf })
        end


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
