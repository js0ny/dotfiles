{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    sops
  ];
  sops = {
    # enable = true;
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
    };
  };

  home.sessionVariables = {
    OPENROUTER_API_KEY = "$(cat ${config.sops.secrets."OPENROUTER_API_KEY".path})";
    TAVILY_API_KEY = "$(cat ${config.sops.secrets."TAVILY_API_KEY".path})";
  };
}
