if vim.fn.executable('nil') == 1 then
    vim.lsp.start({
        name = 'nil',
        cmd = { 'nil' },
        root_dir = vim.fs.dirname(vim.fs.find({'flake.nix', '.git'}, { upward = true })[1])
    })
end
