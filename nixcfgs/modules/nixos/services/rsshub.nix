{
  pkgs,
  lib,
  config,
  ...
}: let
  chromePath = lib.getExe pkgs.google-chrome;
  port = 1200;
  cfg = config.services.rsshub;
in {
  options.services.rsshub = {
    enable = lib.mkEnableOption "RSSHub: 🧡 Everything is RSSible";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.rsshub;
      description = "RSSHub package to use.";
    };

    browserPackage = lib.mkOption {
      type = lib.types.package;
      default = pkgs.chromium;
      description = "Browser package to use for RSSHub's Puppeteer.";
    };

    port = lib.mkOption {
      type = lib.types.port;
      default = 1200;
      description = "Port for RSSHub to listen on.";
    };

    user = lib.mkOption {
      type = lib.types.str;
      default = "rsshub";
      description = "System user running RSSHub.";
    };

    group = lib.mkOption {
      type = lib.types.str;
      default = "rsshub";
      description = "System group running RSSHub.";
    };

    dataDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/rsshub";
      description = "Working directory for RSSHub.";
    };

    envFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = ''
        Optional environment file passed to systemd via EnvironmentFile.
        Intended for secrets or site-specific variables.
      '';
    };

    extraEnvironment = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      description = "Extra plain-text environment variables for RSSHub.";
    };

    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to open the configured port in the firewall.";
    };
  };

  config = lib.mkIf cfg.enable (let
    chromePath = lib.getExe cfg.browserPackage;
  in {
    users.groups.${cfg.group} = {};
    users.users.${cfg.user} = {
      isSystemUser = true;
      group = cfg.group;
      home = cfg.dataDir;
      createHome = true;
      description = "RSSHub Service User";
    };
    systemd.tmpfiles.rules = [
      "d ${cfg.dataDir}/.cache/puppeteer 0755 ${cfg.user} ${cfg.group} - -"
    ];

    environment.systemPackages = with pkgs; [
      cfg.package
      cfg.browserPackage
    ];
    systemd.services.rsshub = {
      description = "RSSHub: 🧡 Everything is RSSible";
      after = ["network-online.target"];
      wantedBy = ["multi-user.target"];
      environment =
        {
          PUPPETEER_EXECUTABLE_PATH = chromePath;
          PUPPETEER_CACHE_DIR = "${cfg.dataDir}/.cache/puppeteer";
          PORT = toString cfg.port;
          NODE_ENV = "production";
        }
        // cfg.extraEnvironment;

      serviceConfig =
        {
          ExecStart = lib.getExe cfg.package;
          Restart = "always";
          RestartSec = "10s";
          User = cfg.user;
          Group = cfg.group;
          WorkingDirectory = cfg.dataDir;
          StateDirectory = "rsshub";
          CacheDirectory = "rsshub";
          PrivateTmp = true;
          NoNewPrivileges = true;
          ProtectSystem = "strict";
          ProtectHome = true;
        }
        // lib.optionalAttrs (cfg.envFile != null) {
          EnvironmentFile = cfg.envFile;
        };
      path = [
        cfg.browserPackage
      ];
    };
    networking.firewall.allowedTCPPorts = lib.mkIf cfg.openFirewall [cfg.port];
  });
}
