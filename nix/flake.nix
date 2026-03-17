{
  description = "NixOS & Home Manager configuration of justin";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xremap-flake = {
      url = "github:xremap/nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    starship-jj = {
      url = "gitlab:lanastara_foss/starship-jj";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      mkNixosConfig = hostname: nixpkgs.lib.nixosSystem rec {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/${hostname}
          # Home Manager as a module configuration. When using Home Manager on a NixOS system,
          # we can apply these configurations with `sudo nixos-rebuild switch --flake .#hostname`.
          home-manager.nixosModules.default {
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.users."justin" = import ./hosts/${hostname}/home.nix;
          }
        ];
      };

      mkHomeConfig = path: home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [ path { non-nixos.enable = true; } ];
        extraSpecialArgs = { inherit inputs; };
      };
    in
    {
      nixosConfigurations = {
        ct14-a4 = mkNixosConfig "ct14-a4";
        nixos-x1c6 = mkNixosConfig "nixos-x1c6";
      };

      # Standalone Home Manager configuration. When using Home Manager on a non-NixOS system,
      # we can apply these configurations with `home-manager switch --flake .#default`.
      # If any host needs special configuration, it can have it's own home.nix file and
      # we can apply it with `home-manager switch --flake .#hostname`.
      homeConfigurations = {
        # Don't need to specify a custom home.nix for default.
        default = mkHomeConfig ./modules/home-manager/home.nix;
        "justin@justin-arch" = mkHomeConfig ./hosts/non-nixos/justin-arch/home.nix;
      };
    };
}
