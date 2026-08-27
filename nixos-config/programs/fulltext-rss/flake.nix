{
  description = "Full Text RSS service flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs }:
    {
      nixosModules.default = import ./module.nix;
    };
}

