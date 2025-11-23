{
  description = "My NixOs Flake Configurations";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{
    self,
    nixpkgs,
    nvf,
    ...
  }: let
    inherit (self) outputs;
    lib = nixpkgs.lib;
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        specialArgs = {
          inherit inputs system;
        };
        modules = [
          ./system/core.nix
          {
            specialisation = {
              kde.configuration = import ./kde/kde.nix;
              cosmic.configuration = import ./cosmic/cosmic.nix;
              hyprland.configuration = import ./hyprland/hyprland.nix;
            };
          }
        ];
      };
      wsl = lib.nixosSystem {
        specialArgs = {
          inherit inputs system;
        };
        modules = [
          ./wsl/wsl.nix
          nvf.nixosModules.default
        ];
      };
    };
  };
}
