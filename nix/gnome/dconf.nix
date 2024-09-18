{ lib, ... }:

{
  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Primary><Alt>t";
      command = "alacritty";
      name = "open-terminal";
    };
    "org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-left = ["<Alt>h"];
      switch-to-workspace-right = ["<Alt>l"];
    };
    "org/gnome/desktop/input-sources" = {
      sources = [ (lib.hm.gvariant.mkTuple [ "xkb" "us" ]) ];
      xkb-options = [ "caps:swapescape" ];
    };
  };
}
