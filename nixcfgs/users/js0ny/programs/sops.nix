{
  pkgs,
  config,
  lib,
  ...
}: let
  secretPaths = {
    OPENROUTER_API_KEY = config.sops.secrets."OPENROUTER_API_KEY".path;
    TAVILY_API_KEY = config.sops.secrets."TAVILY_API_KEY".path;
  };

  posixInit = builtins.concatStringsSep "\n" (
    lib.mapAttrsToList (name: path: ''
      if [ -r "${path}" ]; then
        export ${name}="$(< ${path})"
      fi
    '')
    secretPaths
  );

  fishInit = builtins.concatStringsSep "\n" (
    lib.mapAttrsToList (name: path: ''
      if test -r ${path}
        set -gx "${name}" (cat "${path}")
      end
    '')
    secretPaths
  );
in {
  home.packages = [pkgs.sops];
  sops = {
    defaultSopsFile = ../../../secrets/secrets.yaml;
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    age.generateKey = true;
    secrets = {
      "OPENROUTER_API_KEY" = {
        key = "openrouter_api";
      };
      "TAVILY_API_KEY" = {
        key = "tavily_api";
      };
      "ANKI_SYNC_KEY" = {
        key = "anki_sync_key";
      };
      # OpenClaw secrets
      "OPENCLAW_GATEWAY_TOKEN" = {
        key = "openclaw_gateway_token";
      };
      "OPENCLAW_TGBOT_TOKEN" = {
        key = "openclaw_tgbot_token";
      };
      "TELEGRAM_USER_ID_AMS" = {
        key = "telegram_userid_ams";
      };
      # Optional OpenClaw secrets (uncomment as needed)
      # "DISCORD_BOT_TOKEN" = {
      #   key = "discord_bot_token";
      # };
      # "OPENAI_API_KEY" = {
      #   key = "openai_api_key";
      # };
      # "GOOGLE_PLACES_API_KEY" = {
      #   key = "google_places_api_key";
      # };
    };
  };

  programs = {
    zsh.initContent = posixInit;
    bash.bashrcExtra = posixInit;
    fish.interactiveShellInit = fishInit;
  };
}
