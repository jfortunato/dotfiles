# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, inputs, lib, ... }:

{
  imports =
    [
      inputs.disko.nixosModules.disko
      ./disk-config.nix
      # Common system configuration.
      ../../modules/nixos/system.nix
      # Common intel laptop configuration.
      ../../modules/nixos/intel-laptop-ssd.nix
      # Configs from nixos-hardware.
      inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-6th-gen

      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Hide the boot menu. Hold down space during boot to show it.
  boot.loader.timeout = 0;

  networking.hostName = "nixos-x1c6";
  networking.hostId = "007f0200";

  services.zfs.autoScrub.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
