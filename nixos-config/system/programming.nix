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

    nodejs
    tree-sitter

    unityhub

    neovim

    jetbrains.rider
    jetbrains.webstorm
  ];
}
