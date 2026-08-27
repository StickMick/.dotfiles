# Full Text RSS NixOS Configuration

This is a native NixOS module for running Full Text RSS using PHP-FPM and Nginx.

## Usage

Add this to your NixOS configuration:

```nix
services.fulltext-rss = {
  enable = true;
  port = 80;
  adminPassword = ""; # Leave empty to disable admin section
};
```

## Options

- `enable`: Enable the Full Text RSS service
- `port`: Port to expose the service on localhost (default: 80)
- `adminPassword`: Password for the admin panel (default: "" - disabled). Set at runtime via environment variable, never stored in Nix store.
- `memoryLimit`: Memory limit for PHP-FPM processes (default: "2G")

## How It Works

- **Application Package**: `package.nix` defines a reproducible Nix derivation that fetches and packages Full Text RSS
- **PHP-FPM**: Runs Full Text RSS in a dedicated pool with configurable process management
- **Nginx**: Web server configured to route PHP requests to PHP-FPM with security settings
- **Systemd Setup Service**: `fulltext-rss-setup` copies the packaged application to `/var/lib/fulltext-rss` and creates an ephemeral environment file
- **State Directory**: `/var/lib/fulltext-rss` holds the application, cache, and custom configurations
- **Admin Password Injection**: Password value from NixOS config is written to `/run/fulltext-rss.env` (tmpfs) at startup, loaded by PHP-FPM via systemd EnvironmentFile—never stored in Nix store or configuration files

## Directories

- `/var/lib/fulltext-rss/` - Application root
- `/var/lib/fulltext-rss/cache/` - RSS cache
- `/var/lib/fulltext-rss/site_config/custom/` - Custom site configurations

## Logs

View service logs with:
```bash
journalctl -u fulltext-rss-setup.service
journalctl -u phpfpm-fulltext-rss.service
journalctl -u nginx.service
```

## Custom Configurations

Place your custom site config files in `/var/lib/fulltext-rss/site_config/custom/`

## Upgrades

When upgrading to a new version:
1. Update the `version` in `package.nix`
2. Update the `sha256` hash to match the new release
3. Run `nixos-rebuild switch` to deploy the update
4. The setup service automatically copies updated files to `/var/lib/fulltext-rss`

## No Runtime Downloads

Unlike the Docker approach, the application is packaged at build time via Nix:
- Version pinning via `package.nix` and `flake.lock`
- Checksum verification ensures integrity
- No network calls during service startup
- Reproducible deployments across systems
- **Secrets Safety**: Admin password passed via environment variable to PHP-FPM pool, never stored in Nix store or configuration files
- **Updates**: Configuration rebuilds (`nixos-rebuild switch`) automatically deploy application updates

