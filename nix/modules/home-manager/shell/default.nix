{config, pkgs, ...}: {
  imports = [
    ./kitty/kitty.nix
    ./bash.nix
    ./zsh.nix
  ];

  programs.alacritty = {
    enable = true;
    package = (config.lib.nixGL.wrap pkgs.alacritty);
    settings = {
      window = {
        opacity = 0.9;
      };
    };
  };

  programs.ghostty = {
    enable = true;
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
}
