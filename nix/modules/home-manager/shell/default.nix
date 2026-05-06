{config, pkgs, ...}: {
  imports = [
    ./kitty/kitty.nix
    ./ghostty/ghostty.nix
    ./bash.nix
    ./zsh.nix
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.9;
      };
    };
  };

  programs.dircolors = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    settings = {
      # There is currently an issue using the right_format with unicode characters
      # https://github.com/starship/starship/issues/6524
      format = "$all$directory$shlvl$character";
      cmd_duration = {
        min_time = 0;
        show_milliseconds = true;
      };
      nix_shell = {
        # Only show the icon
        format = "via [$symbol]($style) ";
      };
      # Add additional prompt symbols for each shell level. (Useful with nix shell)
      shlvl = {
        disabled = false;
        format = "[$symbol]($style)";
        repeat = true;
        symbol = "❯";
        repeat_offset = 1;
        threshold = 0;
      };
      direnv = {
        disabled = false;
      };
    };
  };

  programs.atuin = {
    enable = true;
    settings = {
      style = "compact";
      enter_accept = true;
      smart_sort = true;
      sync_frequency = "10m";
      sync = {
        records = true;
      };
    };
    flags = [ "--disable-up-arrow" ];
  };
}
