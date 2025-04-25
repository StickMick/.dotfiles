{
  description = "Flake to run AssetRipper using an FHS environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    packages = {
      # First, extract the ZIP archive and preserve its internal structure.
      assetRipperSrc = pkgs.stdenv.mkDerivation {
        pname = "assetripper-src";
        version = "1.0"; # Adjust as needed

        src = pkgs.fetchurl {
          url = "https://github.com/AssetRipper/AssetRipper/releases/latest/download/AssetRipper_linux_x64.zip";
          sha256 = "sha256-IwhnbOCQCbmjq0Z8/t/jYcjreTIGaIHzkTGXmP+K7/I=";
        };

        buildInputs = [pkgs.unzip];

        # Unzip the archive to $out keeping its structure intact.
        installPhase = ''
          mkdir -p $out
          unzip $src -d $out
          chmod +x $out/AssetRipper.GUI.Free
        '';
      };

      # Then wrap the extracted release using a FHS environment.
      assetRipperFHS = pkgs.buildFHSEnv {
        name = "assetripper-fhs-env";
        # If additional packages (commands or libraries) are needed inside the FHS
        # environment, add them here as a list. For now, we don't need any.
        targetPkgs = pkgs: [];
        # Mount the extracted release at /app
        extraMounts = [
          {
            source = "${self.packages.assetRipperSrc}";
            target = "/app";
          }
        ];
        # The runScript will be executed within the FHS environment.
        runScript = ''
          echo "Launching AssetRipper..."
          # Change directory to /app if you prefer running from there.
          cd /app
          chmod +x /app/AssetRipper.GUI.Free
          # Execute the main binary. Adjust the path if needed.
          exec /app/AssetRipper.GUI.Free
        '';
      };
    };

    apps.x86_64-linux.default = {
      type = "app";
      # This app entry makes it convenient to run the FHS environment.
      program = "${self.packages.assetRipperFHS}";
    };
  };
}
