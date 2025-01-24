{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./gnome
    ./shell
    ./xdg
    ./non-nixos
    ./key-remaps.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "justin";
  home.homeDirectory = "/home/justin";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    curl
    wget
    neovim
    git
    tmux
    xclip # terminal clipboard
    universal-ctags
    (config.lib.nixGL.wrap google-chrome)
    (config.lib.nixGL.wrap firefox)

    # fonts
    # For some reason kitty crashes sometimes when using nix fonts in non-NixOS system, so
    # for now I'll install these fonts with the system package manager. I'd also prefer to
    # use these non-patched fonts instead of the patched Nerd Fonts (https://sw.kovidgoyal.net/kitty/faq/#kitty-is-not-able-to-use-my-favorite-font).
    #hack-font
    #noto-fonts
    #source-code-pro
    #jetbrains-mono
    #(pkgs.nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })

    # archives
    zip
    gzip
    xz
    unzip
    zstd
    gnutar

    # utils
    fzf
    rsync
    gdu # better than `du` for disk usage analysis
    ripgrep # faster `grep`
    fd # faster `find`
    eza # better `ls`

    # networking tools
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    nmap # A utility for network discovery and security auditing
    whois # A utility for querying the whois database
    netcat-openbsd # A simple utility for reading and writing data across network connections
    nettools # netstat, ifconfig, route, etc.
    iproute2 # ip, ss, etc.

    # system monitoring
    htop
    btop
    strace # system call monitoring
    lsof # list open files

    # system tools
    usbutils # lsusb
    util-linux # mkfs, cfdisk, etc.

    # development tools
    jetbrains.idea-ultimate
    # language servers for neovim
    gopls # language server for Go
    phpactor # language server for PHP
    nil # language server for nix
    go # needed globally for `gopls`
    nodejs # needed globally for GitHub Copilot

    # misc
    pv
    neofetch
    quickemu
    cloudflared
    vlc
    gimp
    inkscape
    libreoffice-still
    (config.lib.nixGL.wrap keeweb)
    bitwarden-desktop
    distrobox
    nh

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/justin/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
     EDITOR = "nvim";
     # Set the FLAKE environment variable for `nh` (nix-helper)
     FLAKE = "/home/justin/.dotfiles/nix";
     GOBIN = "${config.home.homeDirectory}/.local/bin"; # Place go binaries installed with `go install` in this directory (instead of the default `~/go/bin`)
     GOPATH = "${config.xdg.dataHome}/go"; # Use an XDG directory for GOPATH (instead of the default `~/go`)
     GOMODCACHE = "${config.xdg.cacheHome}/go/mod"; # Use an XDG directory for GOCACHE (instead of the default `$GOPATH/pkg/mod`)
  };

  home.sessionPath = [
    # Add the ~/.local/bin directory to the PATH
    "${config.home.homeDirectory}/.local/bin"
  ];

  fonts.fontconfig.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
