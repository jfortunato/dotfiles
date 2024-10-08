alias ll='ls -alF'
alias dcu='docker compose up -d'
alias dcs='docker compose stop'
alias spec="phpspec describe"
# usage `cat ugly.json | prettyjson`
alias prettyjson='python -m json.tool'
alias hm-update-packages='~/.dotfiles/nix/hm-update-packages.sh'
# Fixes some ssh issues when using kitty (https://wiki.archlinux.org/title/Kitty#Terminal_issues_with_SSH)
# Also gives some extra features (https://sw.kovidgoyal.net/kitty/kittens/ssh/)
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh --kitten color_scheme=Gruvbox\ Dark"
# Alias all vim commands to nvim
alias vim='nvim'
alias vi='nvim'
# Emulate gvim with kitty + regular nvim
alias gvim='kitty_launch_nvim --detach'
