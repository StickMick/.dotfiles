{
  description = "My NixOs Flake Configurations";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-26.05";
    };
    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    neovim-custom = {
      url = "path:./programs/neovim";
    };
    fulltext-rss-custom = {
      url = "path:./programs/fulltext-rss";
    };
  };

  outputs = inputs@{
    self,
    nixpkgs,
    nixpkgs-unstable,
    neovim-custom,
    fulltext-rss-custom,
    ...
  }: let
    inherit (self) outputs;
    lib = nixpkgs.lib;
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        specialArgs = {
          inherit inputs system fulltext-rss-custom;
        };
        modules = [
          ./system/core.nix
          ./kde/kde.nix
        ];
      };
    };
  };
}
