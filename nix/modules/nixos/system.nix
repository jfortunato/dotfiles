{ config, pkgs, ... }:

{
  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  boot.tmp.cleanOnBoot = true;

  # Enable automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Allow quick edits to /etc/hosts (otherwise it is readonly on NixOS)
  environment.etc.hosts.mode = "0644";

  services.tailscale.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "justin";
  # It seems there is some kind of race condition with autoLogin that causes a problem
  # with my session variable being set to EDITOR=nano (and who knows what other problems)
  # The following 2 lines should help with that.
  # https://github.com/NixOS/nixpkgs/issues/103746
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.justin = {
    isNormalUser = true;
    description = "Justin";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
    initialHashedPassword  = "$6$PfPV1U6Qb1YIqteW$rZQyGPUnIU45m6HBDc/1lgRQDPuAdBXGIUjHrsLOhLmYnrE.dIF1mvbT/DTO.9g04P/wMkS4D8SDa/eMrJrtq1";
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # In order for xremap to work without sudo, the "uinput" kernel module must be loaded and the user
  # must be in the "input" and "uinput" groups.
  #
  # Note for non-NixOS systems: To check if the "uinput" kernel module is loaded, run:
  # `lsmod | grep uinput`.
  # If it is not loaded, create the file `/etc/modules-load.d/uinput.conf` with the content: `uinput`.
  # Then add the following udev rule and reboot:
  # `echo 'KERNEL=="uinput", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/99-input.rules`
  # Also note that it may not be necessary to add the user to the "uinput" group on non-NixOS systems.
  # https://github.com/xremap/xremap?tab=readme-ov-file#running-xremap-without-sudo
  hardware.uinput.enable = true;
  users.groups.uinput.members = [ "justin" ];
  users.groups.input.members = [ "justin" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  fonts.packages = with pkgs; [
    hack-font
    noto-fonts
    source-code-pro
    jetbrains-mono
    #nerd-fonts.symbols-only
    (pkgs.nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; }) # Remove & replace with above line in NixOS 25.05
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  virtualisation.docker.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
