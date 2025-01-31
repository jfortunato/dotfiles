# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, inputs, lib, ... }:

{
  imports =
    [
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

  boot.initrd.luks.devices."luks-2bb4bb03-dbd5-48a9-b7bd-3625dec64253" = {
    device = "/dev/disk/by-uuid/2bb4bb03-dbd5-48a9-b7bd-3625dec64253";
    allowDiscards = true;
    keyFileSize = 4096;
    keyFile = "/dev/sda";
    fallbackToPassword = true;
  };

  boot.initrd.luks.devices."luks-83574355-0b6e-445b-b5ec-04be1afb12da" = {
    device = "/dev/disk/by-uuid/83574355-0b6e-445b-b5ec-04be1afb12da";
    allowDiscards = true;
    keyFileSize = 4096;
    keyFile = "/dev/sda";
    fallbackToPassword = true;
  };

  networking.hostName = "nixos-x1c6";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
