{ pkgs, inputs, ... }:

''
-- Mapping of language server names to their config. The config should supply the cmd and any additional settings to be merged with the default config from nvim-lspconfig.
local language_servers = {
  gopls = { cmd = { '${pkgs.gopls}/bin/gopls' } },
  phpactor = { cmd = { '${pkgs.phpactor}/bin/phpactor', 'language-server' } },
  nixd = {
    cmd = { '${pkgs.nixd}/bin/nixd' },
    settings = {
      nixd = {
        nixpkgs = {
          expr = 'import (builtins.getFlake "${inputs.self}").inputs.nixpkgs { }',
        },
        formatting = {
          command = { "nixfmt" },
        },
        options = {
          home_manager = {
            expr = '(builtins.getFlake "${inputs.self}").homeConfigurations.default.options',
          },
        },
      },
    }
  },
  bashls = { cmd = { '${pkgs.bash-language-server}/bin/bash-language-server', 'start' } },
}

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

for name, config in pairs(language_servers) do
  config.capabilities = capabilities
  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end
''
