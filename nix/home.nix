{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    # There are issues when using some applications that use OpenGL on a non-NixOS system.
    # See: https://github.com/nix-community/nixGL
    # Home Manager does not integrate with nixGL at this time, but there is currently an
    # open PR to add support: https://github.com/nix-community/home-manager/pull/5355
    (builtins.fetchurl {
      url = "https://raw.githubusercontent.com/Smona/home-manager/nixgl-compat/modules/misc/nixgl.nix";
      sha256 = "01dkfr9wq3ib5hlyq9zq662mp0jl42fw3f6gd2qgdf8l8ia78j7i";
    })
    ./gnome
    ./shell
  ];

  nixGL.prefix = "${inputs.nixGL.packages."${pkgs.system}".nixGLIntel}/bin/nixGLIntel";

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
    vim-full # vim & gvim
    tmux
    powerline-fonts
    powerline-symbols
    xclip
    universal-ctags
    (config.lib.nixGL.wrap google-chrome)
    (config.lib.nixGL.wrap firefox)

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
    ncdu
    ripgrep

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

    # development tools
    #docker
    jetbrains-toolbox

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

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs.git.enable = true;

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

  xdg = {
    enable = true;
    configFile = {
      "vim/vimrc".source = ../vim/vimrc;
      "vim/after/syntax/html.vim".source = ../vim/after/syntax/html.vim;
      "vim/after/syntax/htmljinja.vim".source = ../vim/after/syntax/htmljinja.vim;
      "vim/colors/molokai.vim".source = ../vim/colors/molokai.vim;
      "vim/snippets/html.snippets".source = ../vim/snippets/html.snippets;
      "vim/snippets/javascript.snippets".source = ../vim/snippets/javascript.snippets;
      "vim/snippets/php.snippets".source = ../vim/snippets/php.snippets;
      "ideavim/ideavimrc".source = ../ideavim/ideavimrc;
      "git/config".source = ../git/config;
      "git/ignore".source = ../git/ignore;
      "tmux/tmux.conf".source = ../tmux/tmux.conf;
      "tmux/layout.conf".source = ../tmux/layout.conf;
    };
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
    # EDITOR = "emacs";
  };

  targets.genericLinux.enable = true;

  fonts.fontconfig.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}