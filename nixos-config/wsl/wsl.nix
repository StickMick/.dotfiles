{
  config,
  pkgs,
  ...
}: {
  imports = [
    <nixos-wsl/modules>
  ];
  wsl.enable = true;
  wsl.defaultUser = "nixos";

  nix.settings.experimental-features = ["nix-command" "flakes"];

  fonts.packages = with pkgs; [
    fira-code
  ];

        environment.systemPackages = with pkgs; [
                git
                btop
                tmux
        ]

}
