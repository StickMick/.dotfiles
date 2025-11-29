{
  config,
  pkgs,
  ...
}: let
  unstable = import <nixos-unstable> {
    config = {
      allowUnfree = true;
    };
  };
in {
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "stick";
  };

  environment.systemPackages = with pkgs; [
    qbittorrent
    protonvpn-gui
  ];
}
