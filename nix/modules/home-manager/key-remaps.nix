{ lib, config, ... }:

{
  options = {
    key-remaps.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to enable key remaps";
    };
  };

  config = lib.mkIf config.key-remaps.enable {
    # GNOME reads XKB options from dconf, including on Wayland.
    dconf.settings."org/gnome/desktop/input-sources" = {
      xkb-options = [ "caps:escape" ];
    };

    # Keep the same remap for X sessions managed by Home Manager.
    home.keyboard = {
      options = [ "caps:escape" ];
    };
  };
}
