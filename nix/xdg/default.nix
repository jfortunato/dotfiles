{config, ...}: {
  xdg = {
    enable = true;
    configFile = {
      "nvim/init.vim".source = ../../nvim/init.vim;
      "nvim/colors/tomorrow_night.vim".source = ../../nvim/colors/tomorrow_night.vim;
      "nvim/snippets/html.snippets".source = ../../nvim/snippets/html.snippets;
      "nvim/snippets/javascript.snippets".source = ../../nvim/snippets/javascript.snippets;
      "nvim/snippets/php.snippets".source = ../../nvim/snippets/php.snippets;
      "ideavim/ideavimrc".source = ../../ideavim/ideavimrc;
      "git/config".source = ../../git/config;
      "git/ignore".source = ../../git/ignore;
      "tmux/tmux.conf".source = ../../tmux/tmux.conf;
      "tmux/layout.conf".source = ../../tmux/layout.conf;
    };
    desktopEntries = {
      "kitty_launch_nvim" = {
        type = "Application";
        name = "NeoVim (Kitty)";
        genericName = "Text Editor";
        comment = "Edit text files";
        startupNotify = true;
        exec = "kitty_launch_nvim %F";
        categories = ["Utility" "TextEditor"];
        icon = "nvim";
        mimeType = ["text/english" "text/plain" "text/x-makefile" "text/x-c++hdr" "text/x-c++src" "text/x-chdr" "text/x-csrc" "text/x-java" "text/x-moc" "text/x-pascal" "text/x-tcl" "text/x-tex" "application/x-shellscript" "text/x-c" "text/x-c++"];
      };
    };
    mime.enable = true;
  };
}

