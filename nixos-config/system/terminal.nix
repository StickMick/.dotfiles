{
  config,
  pkgs,
  ...
}: let
  zshrcContent =
    builtins.replaceStrings
    ["@OH_MY_ZSH@" "@ZSH_AUTOSUGGESTIONS@" "@ZSH_SYNTAX_HIGHLIGHTING@"]
    [
      "${pkgs.oh-my-zsh}/share/oh-my-zsh"
      "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
      "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    ]
    (builtins.readFile ../programs/zsh/devshell.zsh);

  commonShellHook = ''
    # Generate a per-session Zsh config
    export ZDOTDIR=$(mktemp -d)
    cat > "$ZDOTDIR/.zshrc" << 'ZSHEOF'
    ${zshrcContent}
    ZSHEOF

    export SHELL="${pkgs.zsh}/bin/zsh"

    if [ -z "$ZELLIJ" ]; then
      exec zellij --config ${../programs/zellij/config.kdl}
    fi
    exec "$SHELL"
  '';
in {
  system.activationScripts.zellijConfig = let
    home = config.users.users.stick.home;
  in {
    text = ''
      mkdir -p ${home}/.config/zellij
      ln -sf ${home}/.dotfiles/nixos-config/programs/zellij/config.kdl \
        ${home}/.config/zellij/config.kdl
    '';
  };

  programs.bash.interactiveShellInit = commonShellHook;


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    ghostty

    # Interactive bash (with programmable completion support)
    bashInteractive

    # Shell
    zsh
    oh-my-zsh
    zsh-autosuggestions
    zsh-syntax-highlighting

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

    # Configured NVF Neovim from local flake
    (builtins.getFlake (toString ../programs/nvf)).packages.${pkgs.system}.default
  ];
}
