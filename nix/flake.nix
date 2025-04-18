{
  description = "NixOS & Home Manager configuration of justin";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xremap-flake = {
      url = "github:xremap/nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixgl, disko, ... }@inputs:
    {
      nixosConfigurations = {
        ct14-a4 = nixpkgs.lib.nixosSystem rec {
          specialArgs = { inherit inputs; };
            modules = [
              ./hosts/ct14-a4
              # Home Manager as a module configuration. When using Home Manager on a NixOS system,
              # we can apply these configurations with `sudo nixos-rebuild switch --flake .#ct14-a4`.
              home-manager.nixosModules.default {
                home-manager.extraSpecialArgs = specialArgs;
                home-manager.users."justin" = import ./hosts/ct14-a4/home.nix;
              }
            ];
        };
        nixos-x1c6 = nixpkgs.lib.nixosSystem rec {
          specialArgs = { inherit inputs; };
            modules = [
              ./hosts/nixos-x1c6
              # Home Manager as a module configuration. When using Home Manager on a NixOS system,
              # we can apply these configurations with `sudo nixos-rebuild switch --flake .#nixos-x1c6`.
              home-manager.nixosModules.default {
                home-manager.extraSpecialArgs = specialArgs;
                home-manager.users."justin" = import ./hosts/nixos-x1c6/home.nix;
              }
            ];
        };
      };

      # Standalone Home Manager configuration. When using Home Manager on a non-NixOS system,
      # we can apply these configurations with `home-manager switch --flake .#default`.
      # If any host needs special configuration, it can have it's own home.nix file and
      # we can apply it with `home-manager switch --flake .#hostname`.
      homeConfigurations = {
        default = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          # Don't need to specify a custom home.nix for default, but we do want to enable non-NixOS configurations.
          modules = [
            ./modules/home-manager/home.nix
            {
              non-nixos.enable = true;
            }
          ];
          extraSpecialArgs = {
            inherit inputs;
          };
        };
        "justin@justin-arch" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [ ./hosts/non-nixos/justin-arch/home.nix ];
          extraSpecialArgs = {
            inherit inputs;
          };
        };
      };
    };
}
