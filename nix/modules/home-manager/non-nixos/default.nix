{ lib, config, pkgs, inputs, ... }:

{
  options = {
    non-nixos.enable = lib.mkEnableOption "some configurations when using standalone Home Manager on a non-NixOS system.";
  };

  config = lib.mkIf config.non-nixos.enable {
    targets.genericLinux.enable = true;
  };
}
