{config, ...}: {
  programs.git = {
    enable = true;
    userName = "Justin Fortunato";
    userEmail = "developer@jfortunato.com";
    aliases = {
	  hist = "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short";
	  dt = "difftool";
      next = "!sh -c 'git log --reverse --pretty=%H master | awk \"/$(git rev-parse HEAD)/{getline;print}\" | xargs git checkout'";
	  changes = "difftool HEAD@{1}"; # use this after a pull to see the diff (in the difftool) from our last position
      co = "checkout";
    };
    ignores = [
      "tags"
      ".sass-cache"
      ".idea"
      ".yarn-error.log"
      ".var"
    ];
    extraConfig = {
      color = {
        ui = "auto";
      };
      diff = {
        tool = "gvimdiff";
      };
      difftool = {
        prompt = false;
      };
      "mergetool \"fugitive\"" = {
        cmd = "gvim -f -c \"Gdiff\" \"$MERGED\"";
      };
      merge = {
        tool = "fugitive";
      };
      pull = {
        rebase = false;
      };
      push = {
        default = "simple";
      };
      init = {
        defaultBranch = "main";
      };
    };
  };
}
