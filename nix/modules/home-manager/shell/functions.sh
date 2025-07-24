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
    fd . $1 --type file --exec stat --format '%Y :%y %n' | sort -n | cut -d: -f2-
}
# Similar to what I use in fzf-lua: live_grep, but directly in the terminal.
# See: https://junegunn.github.io/fzf/tips/ripgrep-integration/
live_grep() (
  RELOAD='reload:rg --column --color=always --smart-case {q} || :'
  OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            nvim {1} +{2}     # No selection. Open the current line in Vim.
          else
            nvim +cw -q {+f}  # Build quickfix list for the selected items.
          fi'
  fzf --disabled --ansi --multi \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind "enter:become:$OPENER" \
      --bind "ctrl-o:execute:$OPENER" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
      --preview-window '~4,+{2}+4/3,<80(up)' \
      --query "$*"
)
