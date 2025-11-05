{ lib, config, ... }:

{
  options = {
    jujutsu.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Wether to enable jujutsu";
    };
  };

  config = lib.mkIf config.jujutsu.enable {
    programs.jujutsu = {
      enable = true;
      settings = {
        user = {
          email = "developer@jfortunato.com";
          name = "Justin Fortunato";
        };
        ui = {
          default-command = "log";
        };
        git = {
          auto-local-bookmark = true;
        };
        aliases = {
          dt = [ "diff" "--tool" "kitty_launch_nvim" ];
          hist = [ "log" "-r" "::@" ]; # Show all changes that are descendants of the working copy; shows similar output to my `git hist` alias
        };
        # Use kitty_launch_nvim (which is basically my custom gvim replacement) as the diff tool,
        # and ensure it launches more quickly by:
        # - Not loading any configuration or plugins
        # - Ensure evenly split windows when launching
        # - Basic syntax highlighting
        merge-tools.kitty_launch_nvim = {
          diff-args = [ "-u" "NONE" "-c" "autocmd VimResized * wincmd =" "-c" "syntax enable" "-d" "$left" "$right" ];
          diff-invocation-mode = "file-by-file";
        };
        merge-tools.idea = {
          program = "idea-ultimate";
          diff-args = [ "diff" "$left" "$right" ];
          edit-args = [ "diff" "$left" "$right" ];
          merge-args = [ "merge" "$left" "$right" "$base" "$output" ];
        };
      };
    };

    # Add the jujutsu starship module configuration
    # Keep an eye on https://github.com/starship/starship/issues/6076 for native jujutsu support
    programs.starship.settings = lib.importTOML ./jujutsu-starship.toml;
  };
}
