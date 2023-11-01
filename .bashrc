# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=100000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# default terminal to tmux and start in 256 color mode
#[[ -z "$TMUX" ]] && exec tmux -2
alias tmux="tmux -2"

export MARKPATH=$HOME/.marks
function jump { 
	cd -P $MARKPATH/$1 2>/dev/null || echo "No such mark: $1"
}
function _jump {
	local cur=${COMP_WORDS[COMP_CWORD]}
	local marks=$(find $MARKPATH -type l -printf "%f\n")
	COMPREPLY=($(compgen -W '${marks[@]}' -- "$cur"))
	return 0
}
complete -o default -o nospace -F _jump jump
function mark { 
	mkdir -p $MARKPATH; ln -s $(pwd) $MARKPATH/$1
}
function unmark { 
	rm -i $MARKPATH/$1 
}
function marks {
	ls -la $MARKPATH | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

# start typing a command and use up/down arrows to search through history
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion

set -o vi

export PATH=$PATH:~/.config/composer/vendor/bin:~/Android-Development/adt/sdk/platform-tools:~/Android-Development/adt/sdk/tools:$HOME/.yarn/bin
# Add go to the PATH
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/go/bin/

if command -v docker>/dev/null; then
    alias drm-all="docker rm $(docker ps -a -q)"
fi

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

alias spec="phpspec describe"
# usage `cat ugly.json | prettyjson`
alias prettyjson='python -m json.tool'
alias dcu='docker-compose up -d'
alias dcs='docker-compose stop'

# start shell in tmux
if command -v tmux>/dev/null; then
    [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
fi

md5sumdir() {
    find $1 -type f -exec md5sum {} \; | sort -k 2 | md5sum
}

# This will check all links, including those referencing third party hosts, on a single webpage
check-broken-links() {
    wget --spider --recursive --no-directories --no-verbose --span-hosts --level 1 --wait 1 "$1"
}

# This will check all links from the starting webpage and recurse 10 levels deep. It will not check any
# links referencing third party hosts.
check-broken-links-deep() {
    # remove the --span-hosts option so we don't crawl third party sites
    wget --spider --recursive --no-directories --no-verbose --level 10 --wait 1 "$1"
}

mirror-website() {
    wget --mirror --page-requisites --adjust-extension --span-hosts --convert-links --domains "$1" --no-parent "$1"

    # Explained
    #wget \
        #--mirror \ # Download the whole site.
        #--page-requisites \ # Get all assets/elements (CSS/JS/images).
        #--adjust-extension \ # Save files with .html on the end.
        #--span-hosts \ # Include necessary assets from offsite as well.
        #--convert-links \ # Update links to still work in the static version.
        #--domains "$1" \ # Do not follow links outside this domain.
        #--no-parent \ # Don't follow links outside the directory you pass in.
        #"$1" # The URL to download
}

find-recently-modified() {
    find $1 -type f -print0 | xargs -0 stat --format '%Y :%y %n' | sort -n | cut -d: -f2-
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# use Ctrl-P instead of Ctrl-T for fuzzy file selection
#bind '"\C-p": "\C-x\C-a$a \C-x\C-addi`__fzf_select__`\C-x\C-e\C-x\C-a0Px$a \C-x\C-r\C-x\C-axa "'
bind '"\C-p": "\C-x\C-a$a \C-x\C-addi`__fzf_select_tmux__`\C-x\C-e\C-x\C-a0P$xa"'

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[ -f /var/www/Personal/test/test/node_modules/tabtab/.completions/electron-forge.bash ] && . /var/www/Personal/test/test/node_modules/tabtab/.completions/electron-forge.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source "/etc/profile.d/rvm.sh"
