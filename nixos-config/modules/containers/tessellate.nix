{ config, pkgs, ... }:

{
  containers.tessellate-dev = {
    autoStart = true;

    privateNetwork = false;

    bindMounts = {
      "/home/dev/tessellate/" = {
        hostPath = "/home/stick/shared/tessellate/";
        isReadOnly = false;
      };
    };

    config = { pkgs, ... }: {
      nix.settings.trusted-users = [ "dev" ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      users.users.dev = {
        isNormalUser = true;
        uid = 2000;
        group = "dev";
        home = "/home/dev";
        createHome = true;
      };

      users.groups.dev = {
        gid = 2000;
      };

      security.sudo.enable = false;

      services.openssh.enable = false;

    };
  };
}
