{
  description = "NixOS configuration with COSMIC desktop";

  inputs = {
    url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: {
    nixosConfigurations = {
      cosmic = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux"; # Adjust for your architecture
        modules = [./cosmic.nix];
      };
    };
  };
}
