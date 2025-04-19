{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../core/core.nix
  ];

  services.displayManager.cosmic-greeter.enable = true;

  services.desktopManager.cosmic.enable = true;

  services.displayManager.autoLogin = {
    enable = true;
    user = "stick";
  };
}
