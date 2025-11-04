{config, ...}: {
  sops = {
    # enable = true;
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    age.generateKey = true;
    secrets = {
      "OPENROUTER_API_KEY" = {
        key = "openrouter_api";
      };
    };
  };

  # home.sessionVariables = {
  #   OPENROUTER_API_KEY = config.sops.secrets."OPENROUTER_API_KEY".path;
  # };

  systemd.user.services.sops-envvar = {
    Unit.Description = "[sops-envvar] Auto-source environment variables defined via sops-nix";
    Service = {
      ExecStart = pkgs.writeShellScript "start" ''
        export OPENROUTER_API_KEY=$(cat ${config.sops.secrets."OPENROUTER_API_KEY".path})
      '';
    };
    Install.WantedBy = ["default.target"];
  };
}
