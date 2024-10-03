{config, pkgs, ...}: {
  imports = [
    ./bash.nix
    ./zsh.nix
  ];

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

  programs.kitty = {
    enable = true;
    package = (config.lib.nixGL.wrap pkgs.kitty);
    themeFile = "Tomorrow_Night";
    # The home-manager kitty module will *always* set the shell integration mode to no-rc.
    # This is causing me problems when using ssh and splitting a window with cwd.
    # A hacky workaround is to disable shell integration here, and also re-set the
    # shell_integration to enabled in the kitty.conf, which will override the
    # shell_integration no-rc setting.
    # https://github.com/nix-community/home-manager/issues/5809
    shellIntegration = {
      enableBashIntegration = false;
      enableZshIntegration = false;
    };
    settings = {
      shell_integration = "enabled";
      hide_window_decorations = "yes";
      remember_window_size = "no";
      dynamic_background_opacity = "yes"; # Allow changing opacity with kitty_mod + a > l(ess) or m(ore)
      background_opacity = "0.9";
      enabled_layouts = "splits,all"; # Use the splits layout by default (and allow all layouts)
      # The zsh history completion is displayed in this color, but the "Tomorrow Night" theme
      # uses #000 for the text which makes it hard to read. This makes it a more readable color.
      color8 = "#767676";
      font_family = "family='Source Code Pro' postscript_name=SourceCodePro-Regular";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      tab_bar_style = "powerline";
      tab_bar_min_tabs = "1"; # Always show the tab bar
      tab_bar_background = "#000";
      tab_bar_margin_height = "5.0 0.0";
      tab_title_template = "{layout_name} {index}: {tab.active_exe}";
      active_tab_foreground = "#000";
      active_tab_background = "#afd700";
      active_tab_font_style = "bold";
      inactive_tab_foreground = "#444";
      inactive_tab_background = "#999";
      inactive_tab_font_style = "normal";
      # Use vim as a scrollback pager (https://github.com/kovidgoyal/kitty/issues/719)
      # vim - make vim read from stdin
      # -u NONE don't load any vimrc
      # -c 'w! /tmp/kitty_scrollback' write stdin to a tmp file
      # -c 'term ++curwin cat /tmp/kitty_scrollback' open the tmp file in vim terminal mode
      # -c "terminal cat /proc/$$/fd/0 -" Open the embedded terminal and read stdin of the shell
      # -c 'set nocompatible' fixes some issues with <cr>
      # -c 'map <cr> :qa!<cr>' quit vim on <cr> (enter)
      # -c 'map q :qa!<cr>' quit vim on q
      # -c 'set clipboard^=unnamed,unnamedplus' simply press 'y' to copy to system clipboard
      scrollback_pager = ''
        vim -
        \ -u NONE
        \ -c 'w! /tmp/kitty_scrollback'
        \ -c 'term ++curwin cat /tmp/kitty_scrollback'
        \ -c 'set nocompatible'
        \ -c 'map <cr> :qa!<cr>'
        \ -c 'map q :qa!<cr>'
        \ -c 'set clipboard^=unnamed,unnamedplus'
      '';
      confirm_os_window_close = "1"; # Prevent accidental closing of kitty
      notify_on_cmd_finish = "invisible 30"; # Notify when a long command finishes
    };
    keybindings = {
      # Setup some keybindings to make it more like tmux
      "`>c" = "new_tab_with_cwd";
      "`>n" = "next_tab";
      "`>p" = "previous_tab";
      "`>v" = "launch --location=vsplit --cwd=current";
      "`>s" = "launch --location=hsplit --cwd=current";
      "`>h" = "neighboring_window left";
      "`>j" = "neighboring_window down";
      "`>k" = "neighboring_window up";
      "`>l" = "neighboring_window right";
      "`>[" = "show_scrollback";
      # Mimics my tmux layout
      "`>shift+p" = "combine : reset_window_sizes : launch --location=vsplit --bias=20 --cwd=current : nth_window -1 : launch --location=hsplit --bias=17 --cwd=current : launch htop : first_window";
    };
  };

  # Replace the default kitty icon with a better one
  xdg.desktopEntries = {
    "kitty" = {
      type = "Application";
      name = "Kitty";
      genericName = "Terminal Emulator";
      comment = "A fast, featureful, GPU based terminal emulator";
      startupNotify = true;
      exec = "kitty";
      icon = ./kitty.png;
      categories = ["System" "TerminalEmulator"];
    };
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    silent = true;
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

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      # A minimal left prompt
      format = "$directory$character";
      # move the rest of the prompt to the right
      right_format = "$all";
      nix_shell = {
        # Only show the icon
        format = "via [$symbol]($style) ";
      };
    };
  };
}
