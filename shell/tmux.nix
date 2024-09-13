{config, ...}: {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    terminal = "screen-256color";
    prefix = "`";
    # use vim keys to navigate panes
    customPaneNavigationAndResize = true;
    mouse = true;
    escapeTime = 0;
    extraConfig = ''
      # use layout
      bind P source-file ${config.xdg.configHome}/tmux/layout.conf

      # act like vim
      setw -g mode-keys vi
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      #bind-key -t vi-copy 'y' copy-selection
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection       clipboard'
      # put tmux buffer to system clipboard
      #bind y run-shell "tmux show-buffer | xclip -sel clip -i" \; display-message "Copied       tmux buffer to system clipboard"

      # just adding repeatable to next/prev windows
      unbind-key n          ; bind-key -r n next-window
      unbind-key p          ; bind-key -r p previous-window

      # splits
      unbind-key v          ; bind-key v split-window -h -c "#{pane_current_path}"
      unbind-key s          ; bind-key s split-window -v -c "#{pane_current_path}"

      # keep current directory when creating new windows
      bind '"' split-window -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      # use the vim-airline colors without needing to start vim first
      if-shell "test -f ~/.tmux-status.conf" "source ~/.tmux-status.conf"

      # neovim :checkhealth recommends these settings
      set-option -g focus-events on
      set-option -sa terminal-features ',xterm-256color:RGB'
    '';
  };

  xdg.configFile."tmux/layout.conf".text = ''
    selectp -t 0              # Select pane 0
    splitw -c "#{pane_current_path}" -h -l 20%          # Split pane 0 horizontally by 20%
    selectp -t 0              # Select pane 1
    splitw -c "#{pane_current_path}" -v -l 17%          # Split pane 1 vertically by 17%
    selectp -t 1              # Select pane 0
    splitw -c "#{pane_current_path}" -h -l 50%          # Split pane 1 horizontally by 50%

    send-keys -t 2 'htop' enter C-l                     # Start htop in bottom middle

    select-pane -t 0                                    # Default selected pane to the biggest one
  '';

}
