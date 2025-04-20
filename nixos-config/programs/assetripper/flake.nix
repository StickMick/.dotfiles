{
  description = "A flake to build and run a Dotnet Core Web API from GitHub";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    assetRipper.url = "github:AssetRipper/AssetRipper";
  };

  outputs = {
    self,
    nixpkgs,
    assetRipper,
  }: let
    pkgs = import nixpkgs {system = "x86_64-linux";};
    source = assetRipper;
  in {
    # Development shell for working on the project
    devShell.x86_64-linux = pkgs.mkShell {
      buildInputs = [
        pkgs.dotnet-sdk
      ];
    };

    # Build the Web API from the GitHub source
    packages.x86_64-linux.default = pkgs.stdenv.mkDerivation {
      name = "AssetRipper";
      src = source;
      buildPhase = ''
        export DOTNET_CLI_HOME=$PWD
        dotnet publish -c Release -o $out
      '';
      installPhase = ''
        mkdir -p $out/bin
        mv $out/* $out/bin/
      '';
    };

    # Application to run the Web API
    apps.x86_64-linux.default = {
      type = "app";
      program = "${self.packages.x86_64-linux.default}/bin/AssetRipper";
    };
  };
}
