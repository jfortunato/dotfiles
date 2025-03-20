if vim.fn.executable('nixd') == 1 then
    vim.lsp.start({
        name = 'nixd',
        cmd = { 'nixd' },
        root_dir = vim.fs.dirname(vim.fs.find({'flake.nix', '.git'}, { upward = true })[1]),
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
end
