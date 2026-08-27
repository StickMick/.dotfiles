{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.services.fulltext-rss;
  fulltext-rss = pkgs.callPackage ./package.nix { };
  ftrUser = "fulltext-rss";
  ftrGroup = "fulltext-rss";
  stateDir = "/var/lib/fulltext-rss";
  envFile = "/run/fulltext-rss.env";
in
{
  options.services.fulltext-rss = {
    enable = mkEnableOption "Full Text RSS service";

    port = mkOption {
      type = types.port;
      default = 80;
      description = "Port to expose the service on";
    };

    adminPassword = mkOption {
      type = types.str;
      default = "";
      example = "mypassword";
      description = "Admin password for the web interface. Leave empty to disable.";
    };

    memoryLimit = mkOption {
      type = types.str;
      default = "2G";
      example = "2G";
      description = "Memory limit for PHP-FPM processes";
    };
  };

  config = mkIf cfg.enable {
    # User and group
    users.users.${ftrUser} = {
      isSystemUser = true;
      group = ftrGroup;
      home = stateDir;
    };

    users.groups.${ftrGroup} = { };

    # PHP-FPM pool
    services.phpfpm.pools.fulltext-rss = {
      user = ftrUser;
      group = ftrGroup;
      settings = {
        "listen" = "/run/phpfpm/fulltext-rss.sock";
        "listen.owner" = "nginx";
        "listen.group" = "nginx";
        "pm" = "dynamic";
        "pm.max_children" = 32;
        "pm.start_servers" = 2;
        "pm.min_spare_servers" = 1;
        "pm.max_spare_servers" = 4;
        "pm.process_idle_timeout" = "10s";
        "php_admin_value[memory_limit]" = cfg.memoryLimit;
        "php_admin_value[upload_max_filesize]" = "100M";
        "php_admin_value[post_max_size]" = "100M";
      } // optionalAttrs (cfg.adminPassword != "") {
        "env[FTR_ADMIN_PASSWORD]" = cfg.adminPassword;
      };
    };

    # Nginx virtualhost
    services.nginx = {
      enable = true;
      virtualHosts."fulltext-rss" = {
        listen = [
          { addr = "0.0.0.0"; port = cfg.port; }
        ];
        root = stateDir;

        locations."/" = {
          index = "index.php";
          tryFiles = "$uri $uri/ /index.php?$args";
        };

        locations."~ \\.php$" = {
          extraConfig = ''
            fastcgi_pass unix:/run/phpfpm/fulltext-rss.sock;
            fastcgi_index index.php;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
            include ${pkgs.nginx}/conf/fastcgi_params;
            fastcgi_param PATH_INFO $fastcgi_path_info;
          '';
        };

        locations."~ /\\.ht" = {
          extraConfig = "deny all;";
        };

        locations."= /cache" = {
          extraConfig = "deny all;";
        };
      };
    };

    # Systemd oneshot service to setup Full Text RSS
    systemd.services.fulltext-rss-setup = {
      description = "Full Text RSS Setup";
      wantedBy = [ "multi-user.target" ];
      before = [ "phpfpm-fulltext-rss.service" "nginx.service" ];

      preStart = ''
        mkdir -p ${stateDir}
        chown ${ftrUser}:${ftrGroup} ${stateDir}
        chmod 755 ${stateDir}
      '';

      script = ''
        # Copy application files from Nix package
        cp -r ${fulltext-rss}/* ${stateDir}/ 
        
        # Set proper permissions for serving files
        chown -R ${ftrUser}:${ftrGroup} ${stateDir}
        chmod -R 755 ${stateDir}
        # Restrict write access to cache and config directories
        chmod 750 ${stateDir}/cache ${stateDir}/site_config
      '';

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
    };

    # PHP-FPM service ordering
    systemd.services.phpfpm = {
      after = [ "fulltext-rss-setup.service" ];
      wants = [ "fulltext-rss-setup.service" ];
    };

    systemd.services.nginx = {
      after = [ "fulltext-rss-setup.service" ];
      wants = [ "fulltext-rss-setup.service" ];
    };

    # Ensure state directory persists
    systemd.tmpfiles.rules = [
      "d ${stateDir} 0755 ${ftrUser} ${ftrGroup} - -"
      "d ${stateDir}/cache 0750 ${ftrUser} ${ftrGroup} - -"
      "d ${stateDir}/site_config/custom 0750 ${ftrUser} ${ftrGroup} - -"
    ];
  };
}
