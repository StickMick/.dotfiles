
{ config, pkgs, inputs, system, ... }:
{
  # Enable dconf (System Management Tool)
  programs.dconf.enable = true;

  # Add user to libvirtd group
  users.users.stick.extraGroups = [ "libvirtd" ];

  # Install necessary packages
  environment.systemPackages = [
    pkgs.virt-manager
    pkgs.virt-viewer
    pkgs.spice
    pkgs.spice-gtk
    pkgs.spice-protocol
    pkgs.win-virtio
    pkgs.win-spice
    pkgs.adwaita-icon-theme
    pkgs.freerdp
    inputs.winboat.packages.${system}.winboat
  ];

  # Manage the virtualisation services
  virtualisation = {
    libvirtd = {
      enable = true;
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

  virtualisation.docker.enable = true;
  hardware.nvidia-container-toolkit.enable = true;
  virtualisation.docker.daemon.settings.features.cdi = true;
}
