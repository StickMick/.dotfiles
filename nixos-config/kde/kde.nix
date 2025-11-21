{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  system.nixos.tags = [ "KDE" ];

  services.desktopManager.plasma6.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
}
