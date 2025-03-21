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

      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "ct14-a4";

  # Randomly generated via: `head -c4 /dev/urandom | od -A none -t x4`
  networking.hostId = "852a83e3";

  services.zfs.autoScrub.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
