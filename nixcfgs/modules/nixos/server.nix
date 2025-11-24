{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.my.host;
in {
  options.my.host = {
    role = mkOption {
      type = types.enum ["server" "desktop" "laptop"];
      default = "server";
      description = "The role of this machine, affects default packages and services.";
    };

    tailscale = {
      # Syntax sugar: mkOption type=bool
      enable = mkEnableOption "Tailscale VPN service";

      ip = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Tailscale VPN IP address.";
      };
    };

    public = {
      ipv4 = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Public IPv4 address.";
      };
    };

    sshKey = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Host ED25519 public key.";
    };
  };

  config = mkMerge [
    {
      time.timeZone = "Etc/UTC";

      services.qemuGuest.enable = true;

      nix.settings.trusted-users = ["root" "@wheel"];
    }

    (mkIf cfg.tailscale.enable {
      services.tailscale.enable = true;

      networking.firewall.allowedUDPPorts = [config.services.tailscale.port];
    })
  ];
}
