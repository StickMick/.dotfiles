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
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    gh
    zig
    vscode
    xclip
    ripgrep
    gnumake
    wget
    fd
    git-credential-oauth
    lazygit
    android-studio
    gcc
    wezterm

    unityhub

    jetbrains.rider
    jetbrains.webstorm
  ];
}
