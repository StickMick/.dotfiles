{
  description = "Standalone Roslyn Language Server";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = f:
        nixpkgs.lib.genAttrs supportedSystems
          (system: f (import nixpkgs { inherit system; }));
    in
    {
      packages = forAllSystems (pkgs:
        let
          roslyn-ls = pkgs.stdenv.mkDerivation {
            pname = "roslyn-language-server";
            version = "0.1.0";

            # Fetch NuGet package
            src = pkgs.fetchNuGet {
              name = "Microsoft.CodeAnalysis.LanguageServer";
              version = "0.1.0";
              sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
            };

            buildInputs = [
              pkgs.dotnet-sdk_8
            ];

            installPhase = ''
              mkdir -p $out/lib
              cp -r $src/* $out/lib/

              mkdir -p $out/bin
              cat > $out/bin/roslyn-ls <<EOF
#!/usr/bin/env bash
exec ${pkgs.dotnet-sdk_8}/bin/dotnet $out/lib/Microsoft.CodeAnalysis.LanguageServer.dll
EOF
              chmod +x $out/bin/roslyn-ls
            '';
          };
        in
        {
          default = roslyn-ls;
        }
      );
    };
}

