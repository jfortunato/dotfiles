{ lib, ... }:

{
  dconf.settings = {
    # Enable custom keybindings
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    # Launch kitty with ctrl+alt+t
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Primary><Alt>t";
      command = "kitty";
      name = "open-terminal";
    };
    # Switch workspaces with alt+h and alt+l
    "org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-left = ["<Alt>h"];
      switch-to-workspace-right = ["<Alt>l"];
    };
    # Add back the minimize/maximize button
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:maximize,close";
    };
    "org/gnome/shell" = {
      # The apps we want pinned to the dock
      favorite-apps = [
        "google-chrome.desktop"
        "keeweb.desktop"
        "bitwarden.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Software.desktop"
        "kitty.desktop"
        "idea-ultimate.desktop"
        "idancecloud.desktop"
        "online-reporting.desktop"
        "google-drive.desktop"
        "youtube-tv.desktop"
        "youtube-music.desktop"
      ];
    };
    # Don't use other workspace apps when alt-tabbing
    "org/gnome/shell/app-switcher" = {
        current-workspace-only = true;
    };
    # Disable natural scrolling
    "org/gnome/desktop/peripherals/touchpad" = {
      natural-scroll = false;
    };
    "org/gnome/desktop/peripherals/mouse" = {
      natural-scroll = false;
    };
    # Use dark theme
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita";
    };
    # Set custom wallpaper
    "org/gnome/desktop/background" = {
      picture-uri-dark = "file:///${../wallpapers/nix-dark.png}";
    };
    "org/gnome/mutter" = {
      # Dynamic number of workspaces instead of fixed
      dynamic-workspaces = true;
      # Enable "Active Screen Edges" (drag window to sides)
      edge-tiling = true;
      # Disable auto maximizing. This is causing my PWA's to not retain their last window size
      auto-maximize = false;
    };
  };
}
