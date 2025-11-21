{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  system.nixos.tags = [ "hyprland" ];

  programs.hyprland = {
    enable = true;
  };

  security.pam.services.hyprlock = {
  };

  programs.xfconf.enable = true;
  programs.thunar.enable = true;

  environment.systemPackages = with pkgs; [
    waybar
    dunst
    libnotify
    swww
    kitty
    rofi
    networkmanagerapplet

    # Wallpaper and colour
    pywal
    python3

    # Screenshots
    hyprshot

    # Lock Screen
    hyprlock

    # Idle timeout
    hypridle
  ];
}
