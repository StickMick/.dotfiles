{
  config,
  pkgs,
  ...
}: {
  imports = [
    # ../system/core.nix
  ];

  services.desktopManager.plasma6.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
}
