{config, pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      size = 100000;
    };
    initContent = ''
      # Enable compatibility with bash's completion system.
      autoload -U bashcompinit && bashcompinit

      source ${./aliases.sh}
      source ${./functions.sh}

      # don't beep on ambiguous options
      setopt nolist_beep
      setopt bash_auto_list

      # Enable vi mode. Keep in mind when debugging that bindkey -v may not actually be
      # necessary since it will automatically by set if $VISUAL or $EDITOR contains the
      # string "vi" (e.g. if you set EDITOR=nvim or VISUAL=nvim. See `man zshzle`).
      bindkey -v
      # Ensure pressing backspace in vi mode deletes the character before the cursor
      bindkey -v '^?' backward-delete-char

      # Set up fzf key bindings and fuzzy completion
      source <(fzf --zsh)
      # Use fzf-tab plugin for better tab completion selection menu
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh

      # use Ctrl-P instead of Ctrl-T for fuzzy file selection
      bindkey -r '^t'
      bindkey '^p' fzf-file-widget
      # Use 'fd' for fuzzy file selection. using Ctrl-P
      export FZF_CTRL_T_COMMAND="fd --type f --hidden --exclude .git"

      # use Ctrl+Space to complete the suggestion from zsh-autosuggestions
      bindkey '^ ' forward-char
    '';
  };

  home.packages = [ pkgs.zsh-fzf-tab ];
}
