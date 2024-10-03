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
      shell.program = "tmux";
      window = {
        decorations = "None";
        opacity = 0.9;
      };
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
      direnv = {
        disabled = false;
      };
    };
  };
}
