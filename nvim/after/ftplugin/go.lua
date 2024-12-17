if vim.fn.executable('gopls') == 1 then
    vim.lsp.start({
        name = 'gopls',
        cmd = { 'gopls' },
        root_dir = vim.fs.dirname(vim.fs.find({'go.mod', '.git'}, { upward = true })[1])
    })
end
