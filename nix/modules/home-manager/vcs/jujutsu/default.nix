{ lib, config, ... }:

{
  options = {
    jujutsu.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Wether to enable jujutsu";
    };
  };

  config = lib.mkIf config.jujutsu.enable {
    programs.jujutsu = {
      enable = true;
      settings = {
        user = {
          email = "developer@jfortunato.com";
          name = "Justin Fortunato";
        };
        ui = {
          default-command = "log";
        };
      };
    };
  };
}
