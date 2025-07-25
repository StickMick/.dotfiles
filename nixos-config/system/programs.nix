
{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { 
      config = { 
        allowUnfree = true; 
      }; 
  };
in 
{
  
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "gtk";
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };

  environment.systemPackages = with pkgs; [
    git

    steam
    discord
    spotify
    obsidian
    krita
    gcc
    zip
    unzip
    # bambu-studio
    orca-slicer
    unityhub

    bolt-launcher

    lutris
    (lutris.override {
      extraLibraries =  pkgs: [
        # List library dependencies here
      ];
      extraPkgs = pkgs: [
        # List package dependencies here
      ];
    })
    wine

    #Terminal
    ghostty
    tmux

    #System Monitor
    btop
    nvtopPackages.full
  ];
}
