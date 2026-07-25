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
  services.ollama = {
    enable = true;
    loadModels = [ "llama3.2:3b" "deepseek-r1:1.5b"];
    package = pkgs.ollama-cuda;
  };
  services.open-webui.enable = true;

  environment.systemPackages = with pkgs; [
    claude-code
  ];
}
