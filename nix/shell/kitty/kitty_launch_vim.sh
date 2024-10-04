#!/usr/bin/env bash

# Check if the --detach flag is passed
# By default when this script is run from a terminal, the original terminal will not be usable as
# it will be attached to the new kitty window running vim. That behavior is desired when running
# something like my custom git difftool, but not when normally running this script from the terminal.
DETACH=false
if [[ "$1" == "--detach" ]]; then
  DETACH=true
  shift
fi

# Build the kitty command
kitty_cmd=(
  kitty
  --title="  Vim"                          # Set the window title to use the vim icon
  --start-as=maximized                       # Start the window maximized
  $([ "$DETACH" = true ] && echo "--detach") # Detach the window if the --detach flag is passed
  -o hide_window_decorations=no              # Show the titlebar to make it feel more like a normal gui window
  -o tab_bar_style=hidden                    # Don't show the kitty tab bar
  -o confirm_os_window_close=0               # Don't show a confirmation dialog when closing the window
  -o linux_display_server=x11                # Use native titlebar instead of kitty's custom titlebar
  vim "$@"                                   # Run vim with any arguments passed to this script
)

# Execute the kitty command
"${kitty_cmd[@]}"
