{ lib, config, pkgs, inputs, ... }:

{
  options = {
    non-nixos.enable = lib.mkEnableOption "some configurations when using standalone Home Manager on a non-NixOS system.";
  };

  config = lib.mkIf config.non-nixos.enable {
    # There are issues when using some packages that require GPU acceleration on non-NixOS systems. Home Manager has a workaround for this using nixGL.
    # To utilize this, we need to wrap programs using the `config.lib.nixGL.wrap` function. That function is always availble, even on NixOS systems, but will
    # be a no-op unless the `nixGL.packages` option is set. We'll do that here.
    #
    # https://nix-community.github.io/home-manager/#sec-usage-gpu-non-nixos
    nixGL.packages = inputs.nixgl.packages;


    targets.genericLinux.enable = true;
  };
}
