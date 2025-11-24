{
  description = "My NixOs Flake Configurations";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
  };

  outputs = inputs@{
    self,
    nixpkgs,
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
          ./kde/kde.nix
        ];
      };
    };
  };
}
