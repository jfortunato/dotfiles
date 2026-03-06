{ lib, config, pkgs, inputs, ... }:

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
      package = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.jujutsu;
      settings = {
        user = {
          email = "developer@jfortunato.com";
          name = "Justin Fortunato";
        };
        ui = {
          default-command = "log";
        };
        git = {
          # Prevent pushing "plan" commits to remotes
          private-commits = "description('plan:*')";
        };
        remotes.origin = {
          auto-track-bookmarks = "*";
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
          # Create empty commit at the tip of the branch with a message. Adapted from https://github.com/jj-vcs/jj/discussions/8498 to
          # include the plan: prefix in the commit message.
          plan = [ "util" "exec" "--" "bash" "-c" ''
            set -euo pipefail
            jj new --no-edit 'heads(@::)' -m "plan: $1"
          '' "" ];
        };
        fileset-aliases = {
          lock = "**/package-lock.json | **/yarn.lock | **/composer.lock | **/flake.lock | **/devenv.lock";
          "not:x" = "~x";
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
          program = "idea";
          diff-args = [ "diff" "$left" "$right" ];
          edit-args = [ "diff" "$left" "$right" ];
          merge-args = [ "merge" "$left" "$right" "$base" "$output" ];
        };
      };
    };


    # Add the jujutsu starship module configuration
    # Keep an eye on https://github.com/starship/starship/issues/6076 for native jujutsu support
    programs.starship.settings = {
      git_status = { disabled = true; };
      git_commit = { disabled = true; };
      git_metrics = { disabled = true; };
      git_branch = { disabled = true; };
      custom.jj = {
        command = "prompt";
        format = "$output";
        ignore_timeout = true;
        shell = [ "starship-jj" "--ignore-working-copy" "starship" ];
        use_stdin = false;
        when = true;
      };
    };
    home.packages = [ inputs.starship-jj.packages.${pkgs.stdenv.hostPlatform.system}.starship-jj ];
  };
}
