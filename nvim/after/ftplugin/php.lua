if vim.fn.executable('phpactor') == 1 then
    vim.lsp.start({
        name = 'phpactor',
        cmd = { 'phpactor', 'language-server' },
        root_dir = vim.fs.dirname(vim.fs.find({'composer.json', '.git', '.phpactor.json', '.phpactor.yml'}, { upward = true })[1])
    })
end
