{ lib, config, inputs, ... }:

{
  imports = [
    inputs.xremap-flake.homeManagerModules.default
  ];

  options = {
    key-remaps.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Wether to enable key remaps";
    };
  };

  config = lib.mkIf config.key-remaps.enable {
    # NOTE: Key remaps may require a restart to take effect.
    # Swap Capslock & Esc in a desktop environment agnostic way.
    services.xremap.enable = true;
    services.xremap.config.modmap = [
      {
        name = "Global";
        remap = {
          "Capslock" = "Esc";
          "Esc" = "Capslock";
        };
      }
    ];
  };
}
