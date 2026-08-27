{ config, lib, pkgs, fulltext-rss-custom, ... }:

{
  # Import Full Text RSS module from the flake
  imports = [
    fulltext-rss-custom.nixosModules.default
  ];

  # Feedr - CLI RSS reader
  environment.systemPackages = with pkgs; [
    feedr
  ];

  # Full Text RSS configuration
  services.fulltext-rss = {
    enable = true;
    port = 7070;
    adminPassword = "";
  };
}


