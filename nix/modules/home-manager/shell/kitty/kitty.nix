{config, pkgs, ...}: {
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
      # Better title bar in gnome
      linux_display_server = "x11";
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
      tab_bar_style = "custom";
      tab_bar_edge = "top";
      tab_bar_align = "left";
      tab_bar_min_tabs = "1"; # Always show the tab bar
      tab_separator = "\"\"";
      tab_bar_margin_height = "0.0 0.0";
      tab_bar_margin_width = "0.0";
      tab_title_template = "{f'{title[:30]}…' if title.rindex(title[-1]) + 1 > 30 else (title.center(6) if (title.rindex(title[-1]) + 1) % 2 == 0 else title.center(5))}";
      active_tab_foreground = "#000";
      active_tab_background = "#b5bd68";
      active_tab_font_style = "bold";
      inactive_tab_foreground = "#444";
      inactive_tab_background = "#999";
      inactive_tab_font_style = "normal";
      # Use nvim as a scrollback pager
      # The explanation for this script can be found here:
      # https://github.com/kovidgoyal/kitty/issues/719#issuecomment-952039731
      scrollback_pager = "${./pager.sh} 'INPUT_LINE_NUMBER' 'CURSOR_LINE' 'CURSOR_COLUMN'";
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
      "f11" = "toggle_fullscreen";
    };
  };

  xdg.configFile."kitty/pager.sh".source = ./pager.sh;
  xdg.configFile."kitty/tab_bar.py".source = ./tab_bar.py;
  xdg.configFile."kitty/ssh.conf".source = ./ssh.conf;

  # Instead of installing gvim, I can emulate the behavior of gvim by launching nvim in a kitty session with a few tweaks. Placing the script in the home.packages section will make it available in the PATH.
  home.packages = with pkgs; [
    (pkgs.writeScriptBin "kitty_launch_nvim" (builtins.readFile ./kitty_launch_nvim.sh))
  ];

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
}
