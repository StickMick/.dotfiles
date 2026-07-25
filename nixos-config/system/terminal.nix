{
  config,
  pkgs,
  inputs,
  ...
}: let
  pkgs-unstable = import inputs.nixpkgs-unstable {
    config = {
      allowUnfree = true;
    };
  };
in {

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histSize = 10000;
    promptInit = ''
      export ZDOTDIR=/etc

      ${pkgs.any-nix-shell}/bin/any-nix-shell zsh --info-right | source /dev/stdin
    '';
    interactiveShellInit = builtins.readFile ../programs/zsh/devshell.zsh;
    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "dirhistory"
        "history"
      ];
    };
  };
  users.defaultUserShell = pkgs.zsh;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    ghostty
    #kitty

    # Interactive bash (with programmable completion support)
    bashInteractive

    # Terminal multiplexer
    zellij

    # Version control
    git
    lazygit
    git-credential-manager # cross-platform credential helper (GCM)

    # Fuzzy finder
    fzf

    # Search & navigation
    ripgrep
    fd
    bat # better cat
    eza # better ls
    zoxide # smarter cd

    # Key management
    keychain # SSH/GPG agent manager
    gnupg
    openssh
    pass # password-store for credential backend

    github-copilot-cli

    # Utilities
    jq
    yq-go
    curl
    wget
    htop
    direnv # per-directory env variables
  ];
}
