{config, ...}: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
    historySize = 100000;
    historyFileSize = 100000;
    # don't put duplicate lines or lines starting with space in the history.
    historyControl = ["ignoreboth"];
    bashrcExtra = ''
      source ${config.home.homeDirectory}/.dotfiles/.aliases.sh
      source ${config.home.homeDirectory}/.dotfiles/.functions.sh

      PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

      # start typing a command and use up/down arrows to search through history
      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'

      set -o vi

      [ -f ~/.fzf.bash ] && source ~/.fzf.bash
      # use Ctrl-P instead of Ctrl-T for fuzzy file selection
      #bind '"\C-p": "\C-x\C-a$a \C-x\C-addi`__fzf_select__`\C-x\C-e\C-x\C-a0Px$a       \C-x\C-r\C-x\C-axa "'
      bind '"\C-p": "\C-x\C-a$a \C-x\C-addi`__fzf_select_tmux__`\C-x\C-e\C-x\C-a0P$xa"'
    '';
  };
}
