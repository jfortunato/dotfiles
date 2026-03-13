{pkgs, inputs, ...}: {
  programs.ghostty = {
    enable = true;
    package = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.ghostty;
    settings = {
      theme = "Tomorrow Night";
      window-theme = "ghostty";
      gtk-titlebar-style = "tabs";
      gtk-wide-tabs = false;
      background-opacity = 0.9;
      keybind = [
        "`>c=new_tab"
        "`>n=next_tab"
        "`>p=previous_tab"
        "`>v=new_split:right"
        "`>s=new_split:down"
        "`>h=goto_split:left"
        "`>j=goto_split:bottom"
        "`>k=goto_split:top"
        "`>l=goto_split:right"
        "f11=toggle_fullscreen"
      ];
      # Disable programming ligatures
      font-feature = "-calt";
      notify-on-command-finish = "unfocused";
      notify-on-command-finish-action = "bell,notify";
      notify-on-command-finish-after = "30s";
      bell-features = "system,attention,title";
      shell-integration-features = "ssh-env";
      # Increase limit from 10MB to 100MB
      scrollback-limit = 100000000;
      config-file = [
        "config-vim-mode"
      ];
    };
  };

  xdg.configFile."ghostty/config-vim-mode".source = ./config-vim-mode;

  # Instead of installing gvim, I can emulate the behavior of gvim by launching nvim in a ghostty session with a few tweaks. Placing the script in the home.packages section will make it available in the PATH.
  home.packages = with pkgs; [
    (pkgs.writeScriptBin "ghostty_launch_nvim" (builtins.readFile ./ghostty_launch_nvim.sh))
  ];
}
