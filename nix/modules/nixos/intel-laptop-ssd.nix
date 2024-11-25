{config, inputs, lib, ...}:

{
  imports =
    [
      # fstrim is also installed by default as a required packaged, provided by util-linux.
      # https://github.com/NixOS/nixpkgs/blob/nixos-24.05/nixos/modules/config/system-path.nix
      inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
      # Enables tlp (only if power-profiles-daemon is not enabled).
      inputs.nixos-hardware.nixosModules.common-pc-laptop
      # Enables intel microcode updates (intel-ucode) & gpu configs
      inputs.nixos-hardware.nixosModules.common-cpu-intel
    ];

  # Monitor & control laptop temperature.
  services.thermald.enable = lib.mkDefault true;
}
