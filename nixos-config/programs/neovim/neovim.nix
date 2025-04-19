{
  inputs.repo.url = "github:stickmick/nvf";

  outputs = { nixpkgs, ... } @ inputs: {
    # Import the `default` package from the flake into your configuration
    nixosConfigurations.mySystem = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.repo.packages.x86_64-linux.default
      ];
    };
  };
}

