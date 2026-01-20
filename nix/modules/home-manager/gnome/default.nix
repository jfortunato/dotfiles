{config, pkgs, ...}: {
  imports = [
    ./dconf.nix
  ];

  home.packages = with pkgs; [
    file-roller
  ];
}

