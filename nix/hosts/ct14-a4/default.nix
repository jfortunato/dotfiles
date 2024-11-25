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

      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-8b724a8f-afb1-47e6-84e9-38d13146eea1".device = "/dev/disk/by-uuid/8b724a8f-afb1-47e6-84e9-38d13146eea1";

  networking.hostName = "ct14-a4";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
