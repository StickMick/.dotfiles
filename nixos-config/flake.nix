{
  description = "My NixOs Flake Configurations";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      cosmic = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./cosmic/cosmic.nix
        ];
      };
      wayland = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hyprland/hyprland.nix
        ];
      };
      kde = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./kde/iGPU.nix
        ];
      };
      wsl = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./wsl/wsl.nix
        ];
      };
    };
  };
}
