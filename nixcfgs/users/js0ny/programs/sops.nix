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
    };
  };

  programs = {
    zsh.initContent = posixInit;
    bash.bashrcExtra = posixInit;
    fish.interactiveShellInit = fishInit;
  };
}
