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
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
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

    # moonlander
    keymapp

    # bolt-launcher

    lutris
    (lutris.override {
      extraLibraries = pkgs: [
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
    zellij

    #System Monitor
    btop
    nvtopPackages.full

    libreoffice-qt

    # Configured NVF Neovim from local flake
    (builtins.getFlake (toString ../programs/nvf)).packages.${pkgs.system}.default
  ];

  programs.bash.interactiveShellInit = ''
    if [[ -z "$ZELLIJ" ]]; then
      zellij
    fi
  '';

  system.activationScripts.zellijConfig = let
    home = config.users.users.stick.home;
  in {
    text = ''
      mkdir -p ${home}/.config/zellij
      ln -sf ${home}/.dotfiles/nixos-config/programs/zellij/config.kdl \
        ${home}/.config/zellij/config.kdl
    '';
  };
}
