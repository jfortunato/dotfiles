{config, pkgs, ...}: {
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
    };
    initExtra = ''
      source ${./aliases.sh}
      source ${./functions.sh}

      # don't beep on ambiguous options
      setopt nolist_beep
      setopt bash_auto_list

      # use Ctrl-P instead of Ctrl-T for fuzzy file selection
      bindkey '^p' fzf-file-widget
      # The oh-my-zsh fzf plugin already sets FZF_DEFAULT_COMMAND to use 'fd', but
      # we want to use 'fd' for the fzf-file-widget as well.
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

      # use Ctrl+Space to complete the suggestion from zsh-autosuggestions
      bindkey '^ ' forward-char

      # Enable short-option completion stacking for example: docker exec -it <tab>
      zstyle ':completion:*:*:docker:*' option-stacking yes
      zstyle ':completion:*:*:docker-*:*' option-stacking yes
    '';
  };
}
