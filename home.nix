{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./dconf.nix
    # There are issues when using some applications that use OpenGL on a non-NixOS system.
    # See: https://github.com/nix-community/nixGL
    # Home Manager does not integrate with nixGL at this time, but there is currently an
    # open PR to add support: https://github.com/nix-community/home-manager/pull/5355
    (builtins.fetchurl {
      url = "https://raw.githubusercontent.com/Smona/home-manager/nixgl-compat/modules/misc/nixgl.nix";
      sha256 = "01dkfr9wq3ib5hlyq9zq662mp0jl42fw3f6gd2qgdf8l8ia78j7i";
    })
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
    git
    curl
    tmux
    vimHugeX # vim & gvim
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

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    #".p10k.zsh".source = ./.p10k.zsh;
    ".vim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.vim";
    ".vimrc".source = ./.vimrc;
    ".ideavimrc".source = ./.ideavimrc;
    ".gitconfig".source = ./gitconfig;
    ".gitignore".source = ./gitignore;

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
    # EDITOR = "emacs";
  };

  targets.genericLinux.enable = true;

  fonts.fontconfig.enable = true;

  programs.alacritty = {
    enable = true;
    package = (config.lib.nixGL.wrap pkgs.alacritty);
    settings = {
      shell.program = "tmux";
      window = {
        decorations = "None";
        opacity = 0.9;
      };
    };
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    terminal = "screen-256color";
    prefix = "`";
    # use vim keys to navigate panes
    customPaneNavigationAndResize = true;
    mouse = true;
    escapeTime = 0;
    extraConfig = ''
      # use layout
      bind P source-file ${config.xdg.configHome}/tmux/layout.conf

      # act like vim
      setw -g mode-keys vi
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      #bind-key -t vi-copy 'y' copy-selection
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection       clipboard'
      # put tmux buffer to system clipboard
      #bind y run-shell "tmux show-buffer | xclip -sel clip -i" \; display-message "Copied       tmux buffer to system clipboard"

      # just adding repeatable to next/prev windows
      unbind-key n          ; bind-key -r n next-window
      unbind-key p          ; bind-key -r p previous-window

      # splits
      unbind-key v          ; bind-key v split-window -h -c "#{pane_current_path}"
      unbind-key s          ; bind-key s split-window -v -c "#{pane_current_path}"

      # keep current directory when creating new windows
      bind '"' split-window -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      # use the vim-airline colors without needing to start vim first
      if-shell "test -f ~/.tmux-status.conf" "source ~/.tmux-status.conf"

      # neovim :checkhealth recommends these settings
      set-option -g focus-events on
      set-option -sa terminal-features ',xterm-256color:RGB'
    '';
  };

  xdg.configFile."tmux/layout.conf".text = ''
    selectp -t 0              # Select pane 0
    splitw -c "#{pane_current_path}" -h -l 20%          # Split pane 0 horizontally by 20%
    selectp -t 0              # Select pane 1
    splitw -c "#{pane_current_path}" -v -l 17%          # Split pane 1 vertically by 17%
    selectp -t 1              # Select pane 0
    splitw -c "#{pane_current_path}" -h -l 50%          # Split pane 1 horizontally by 50%

    send-keys -t 2 'htop' enter C-l                     # Start htop in bottom middle

    select-pane -t 0                                    # Default selected pane to the biggest one
  '';

  programs.bash = {
    enable = true;
    enableCompletion = true;
    historySize = 100000;
    historyFileSize = 100000;
    # don't put duplicate lines or lines starting with space in the history.
    historyControl = ["ignoreboth"];
    bashrcExtra = ''
      source ${config.home.homeDirectory}/.dotfiles/.aliases.sh
      source ${config.home.homeDirectory}/.dotfiles/.functions.sh

      #PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
      PS1='\u@\h:\w\$ '

      # start typing a command and use up/down arrows to search through history
      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'

      set -o vi

      [ -f ~/.fzf.bash ] && source ~/.fzf.bash
      # use Ctrl-P instead of Ctrl-T for fuzzy file selection
      #bind '"\C-p": "\C-x\C-a$a \C-x\C-addi`__fzf_select__`\C-x\C-e\C-x\C-a0Px$a       \C-x\C-r\C-x\C-axa "'
      bind '"\C-p": "\C-x\C-a$a \C-x\C-addi`__fzf_select_tmux__`\C-x\C-e\C-x\C-a0P$xa"'
    '';
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      size = 100000;
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "docker" "docker-compose" "vi-mode" "tmux" "fzf" ];
      #theme = "powerlevel10k/powerlevel10k";
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    initExtraFirst = ''
      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';
    initExtra = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ${config.home.homeDirectory}/.dotfiles/.p10k.zsh
      source ${config.home.homeDirectory}/.dotfiles/.aliases.sh
      source ${config.home.homeDirectory}/.dotfiles/.functions.sh

      # don't beep on ambiguous options
      setopt nolist_beep
      setopt bash_auto_list

      # use Ctrl-P instead of Ctrl-T for fuzzy file selection
      bindkey '^p' fzf-file-widget

      # use Ctrl+Space to complete the suggestion from zsh-autosuggestions
      bindkey '^ ' forward-char

      # Enable short-option completion stacking for example: docker exec -it <tab>
      zstyle ':completion:*:*:docker:*' option-stacking yes
      zstyle ':completion:*:*:docker-*:*' option-stacking yes
    '';
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    stdlib = ''
      # https://github.com/direnv/direnv/wiki/Customizing-cache-location
      : "''${XDG_CACHE_HOME:="''${HOME}/.cache"}"
      declare -A direnv_layout_dirs
      direnv_layout_dir() {
          local hash path
          echo "''${direnv_layout_dirs[$PWD]:=$(
              hash="$(sha1sum - <<< "$PWD" | head -c40)"
              path="''${PWD//[^a-zA-Z0-9]/-}"
              echo "''${XDG_CACHE_HOME}/direnv/layouts/''${hash}''${path}"
          )}"
      }
    '';
  };

  programs.dircolors = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
