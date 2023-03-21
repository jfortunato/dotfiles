# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    docker
    docker-compose
    vi-mode
    tmux
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"



# automatically select first option on ambiguous options (more like bash)
#setopt menu_complete
# don't beep on ambiguous options
setopt nolist_beep
setopt bash_auto_list
#setopt noauto_menu
#setopt complete_in_word


# start shell in tmux
if command -v tmux>/dev/null; then
    [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
fi

# increase the history size so we can remember commands that haven't been used in awhile
HISTSIZE=100000
SAVEHIST=$HISTSIZE

# aliases
alias ll='ls -alF'
alias dcu='docker-compose up -d'
alias dcs='docker-compose stop'


# use vim keybindings
bindkey -v


# manually mark commonly used directories, then run the command `jump $directory` to navigate to it from anywhere
export MARKPATH=$HOME/.marks
function jump { 
	cd -P $MARKPATH/$1 2>/dev/null || echo "No such mark: $1"
}
function _jump {
	local cur=${COMP_WORDS[COMP_CWORD]}
	local marks=$(find $MARKPATH -type l -printf "%f\n")
	COMPREPLY=($(compgen -W "$marks" -- "$cur"))
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


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# use Ctrl-P instead of Ctrl-T for fuzzy file selection
bindkey '^p' fzf-file-widget

# use Ctrl+Space to complete the suggestion from zsh-autosuggestions
bindkey '^ ' forward-char


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


# this will suggest packages that are not already installed
source /etc/zsh_command_not_found


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

autoload -U compinit
compinit -i

source "/etc/profile.d/rvm.sh"
