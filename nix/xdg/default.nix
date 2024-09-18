{config, ...}: {
  xdg = {
    enable = true;
    configFile = {
      "vim/vimrc".source = ../../vim/vimrc;
      "vim/after/syntax/html.vim".source = ../../vim/after/syntax/html.vim;
      "vim/after/syntax/htmljinja.vim".source = ../../vim/after/syntax/htmljinja.vim;
      "vim/colors/molokai.vim".source = ../../vim/colors/molokai.vim;
      "vim/snippets/html.snippets".source = ../../vim/snippets/html.snippets;
      "vim/snippets/javascript.snippets".source = ../../vim/snippets/javascript.snippets;
      "vim/snippets/php.snippets".source = ../../vim/snippets/php.snippets;
      "ideavim/ideavimrc".source = ../../ideavim/ideavimrc;
      "git/config".source = ../../git/config;
      "git/ignore".source = ../../git/ignore;
      "tmux/tmux.conf".source = ../../tmux/tmux.conf;
      "tmux/layout.conf".source = ../../tmux/layout.conf;
    };
  };
}

