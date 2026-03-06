#!/usr/bin/env bash

# Check if the --detach flag is passed
# By default when this script is run from a terminal, the original terminal will not be usable as
# it will be attached to the new ghostty window running vim. That behavior is desired when running
# something like my custom git/jj difftool, but not when normally running this script from the terminal.
DETACH=false
if [[ "$1" == "--detach" ]]; then
  DETACH=true
  shift
fi

# Build the ghostty command
ghostty_cmd=(
	ghostty
	--title="  NeoVim"                  # Set the window title to use the vim icon
	--maximize                           # Start the window maximized
	--class="com.mitchellh.ghostty-nvim" # Set the class to something specific so that we can use alt+tab switch instead of alt+` in gnome
	--gtk-titlebar-style=native          # Use the native titlebar style to make it feel more like a normal gui window
	--confirm-close-surface=false        # Don't show a confirmation dialog when closing the window
	-e nvim "$@"                         # Run nvim as the command in ghostty
)

# Execute the ghostty command
# Redirect all output to /dev/null to prevent any output from ghostty from appearing in the terminal.
if [ "$DETACH" = true ]; then
  nohup "${ghostty_cmd[@]}" > /dev/null 2>&1 &
else
  "${ghostty_cmd[@]}" > /dev/null 2>&1
fi

