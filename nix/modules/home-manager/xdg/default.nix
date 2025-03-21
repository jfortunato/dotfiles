{config, ...}: {
  xdg = {
    enable = true;
    configFile = {
      "nvim/init.vim".source = ../../../../nvim/init.vim;
      "nvim/lua/init.lua".source = ../../../../nvim/lua/init.lua;
      "nvim/lua/lsp.lua".source = ../../../../nvim/lua/lsp.lua;
      "nvim/lua/nvim-cmp.lua".source = ../../../../nvim/lua/nvim-cmp.lua;
      "nvim/colors/tomorrow_night.vim".source = ../../../../nvim/colors/tomorrow_night.vim;
      "nvim/snippets/html.snippets".source = ../../../../nvim/snippets/html.snippets;
      "nvim/snippets/javascript.snippets".source = ../../../../nvim/snippets/javascript.snippets;
      "nvim/snippets/php.snippets".source = ../../../../nvim/snippets/php.snippets;
      "ideavim/ideavimrc".source = ../../../../ideavim/ideavimrc;
      "git/config".source = ../../../../git/config;
      "git/ignore".source = ../../../../git/ignore;
      "tmux/tmux.conf".source = ../../../../tmux/tmux.conf;
      "tmux/layout.conf".source = ../../../../tmux/layout.conf;
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
      # Declare some PWAs. On Chrome, we can get a lot of useful information at `chrome://web-app-internals/`.
      # TODO: Refactor to use a function to generate these entries.
      "idancecloud" = {
        terminal = false;
        type = "Application";
        name = "iDanceCloud";
        exec = "google-chrome-stable --profile-directory=Default --app-id=nckmaipkakdgoghggaoknoppgpmoddin";
        icon = "chrome-nckmaipkakdgoghggaoknoppgpmoddin-Default";
        settings = {
          StartupWMClass = "crx_nckmaipkakdgoghggaoknoppgpmoddin-Default";
        };
      };
      "online-reporting" = {
        terminal = false;
        type = "Application";
        name = "Arthur Murray Online Reporting";
        exec = "google-chrome-stable --profile-directory=Default --app-id=nkjdlpnfnfdlapndgjbknighogbcpajf";
        icon = "chrome-nkjdlpnfnfdlapndgjbknighogbcpajf-Default";
        settings = {
          StartupWMClass = "crx_nkjdlpnfnfdlapndgjbknighogbcpajf-Default";
        };
      };
      "google-drive" = {
        terminal = false;
        type = "Application";
        name = "Google Drive";
        exec = "google-chrome-stable --profile-directory=Default --app-id=aghbiahbpaijignceidepookljebhfak";
        icon = "chrome-aghbiahbpaijignceidepookljebhfak-Default";
        settings = {
          StartupWMClass = "crx_aghbiahbpaijignceidepookljebhfak-Default";
        };
      };
      "youtube-tv" = {
        terminal = false;
        type = "Application";
        name = "YouTube TV";
        exec = "google-chrome-stable --profile-directory=Default --app-id=nlmaamaoahjiilibgbafebhafkeccjac";
        icon = "chrome-nlmaamaoahjiilibgbafebhafkeccjac-Default";
        settings = {
          StartupWMClass = "crx_nlmaamaoahjiilibgbafebhafkeccjac-Default";
        };
      };
      "youtube-music" = {
        terminal = false;
        type = "Application";
        name = "YouTube Music";
        exec = "google-chrome-stable --profile-directory=Default --app-id=cinhimbnkkaeohfgghhklpknlkffjgod";
        icon = "chrome-cinhimbnkkaeohfgghhklpknlkffjgod-Default";
        settings = {
          StartupWMClass = "crx_cinhimbnkkaeohfgghhklpknlkffjgod-Default";
        };
      };
    };
    mime.enable = true;
  };
}

