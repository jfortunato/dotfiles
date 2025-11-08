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
        revset-aliases = {
          # Treat anything that has been pushed to a remote as immutable
          "immutable_heads()" = "builtin_immutable_heads() | remote_bookmarks()";
        };
        aliases = {
          dt = [ "diff" "--tool" "kitty_launch_nvim" ];
          # Show all changes that are descendants of the working copy; shows similar output to my `git hist` alias
          hist = [ "log" "-r" "::@" ];
          # Commonly used alias to move the closest bookmark to the parent of the current working copy
          tug = ["bookmark" "move" "--from" "heads(::@- & bookmarks())" "--to" "@-"];
          # Mimic how git would create a merge commit.
          # e.g. `jj merge-commit staging develop` would create a merge commit on the staging branch, create the same
          # default message that git would, and move the staging bookmark to point to the new merge commit.
          merge-commit = [ "util" "exec" "--" "bash" "-c" ''
            set -euo pipefail
            # Git only appends " into <target-branch>" on branches other than main/master
            # See: https://git-scm.com/docs/git-fmt-merge-msg#Documentation/git-fmt-merge-msg.txt-mergesuppressDest
            if [[ "$1" == "master" || "$1" == "main" ]]; then
              MSG="Merge branch '$2'"
            else
              MSG="Merge branch '$2' into $1"
            fi
            jj new $1 $2
            jj commit -m "$MSG"
            jj bookmark move $1 -t @-
          '' "" ];
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
