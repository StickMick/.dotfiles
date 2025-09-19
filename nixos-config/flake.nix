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

  outputs = {
    self,
    nixpkgs,
    nvf,
  }: let
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        system = "x86_64-linux";
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
        system = "x86_64-linux";
	modules = [
	  ./wsl/wsl.nix
	  nvf.nixosModules.default
	];
      };
    };
  };
}
