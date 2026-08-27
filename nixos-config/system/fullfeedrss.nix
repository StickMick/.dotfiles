{ config, pkgs, ... }: {
  systemd.services.fullfeedrss = {
    description = "Full Text RSS Docker Service";
    after = [ "docker.service" ];
    requires = [ "docker.service" ];
    wantedBy = [ "multi-user.target" ];
    
    environment = {
      COMPOSE_PROJECT_NAME = "fullfeedrss";
    };

    serviceConfig = {
      Type = "simple";
      Restart = "always";
      RestartSec = "5s";
      User = "root";
      WorkingDirectory = "/var/lib/fullfeedrss";
      
      ExecStartPre = "${pkgs.bash}/bin/bash -c 'mkdir -p /var/lib/fullfeedrss/custom'";
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose up";
      ExecStop = "${pkgs.docker-compose}/bin/docker-compose down";
    };
  };

  # Create the docker-compose.yml file
  environment.etc."fullfeedrss/docker-compose.yml" = {
    text = ''
      services:
        fullfeedrss:
          image: "heussd/fivefilters-full-text-rss:latest"
          mem_limit: 2G
          restart: always
          environment:
            # Leave empty to disable admin section
            - FTR_ADMIN_PASSWORD=
          volumes:
            - "rss-cache:/var/www/html/cache/rss"
            - "./custom:/var/www/html/site_config/custom"
          ports:
            - "127.0.0.1:8765:80"
      volumes:
        rss-cache:
    '';
  };

  # Symlink the docker-compose.yml to the working directory
  system.activationScripts.fullfeedrss-setup = ''
    mkdir -p /var/lib/fullfeedrss
    cp /etc/fullfeedrss/docker-compose.yml /var/lib/fullfeedrss/
  '';

  # Add localhost hostname alias
  networking.hosts = {
    "127.0.0.1" = [ "fullfeedrss.local" ];
  };

  # Nginx reverse proxy
  services.nginx = {
    enable = true;
    virtualHosts."fullfeedrss.local" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:8765";
        proxyWebsockets = true;
      };
    };
  };

  # Create shell alias via environment
  environment.shellAliases = {
    rss = "xdg-open http://fullfeedrss.local";
  };
}
