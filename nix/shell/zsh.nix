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
      #theme = "powerlevel10k/powerlevel10k";
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    initExtraFirst = ''
      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';
    initExtra = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ${./.p10k.zsh}
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
