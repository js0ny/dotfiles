{config, ...}: {
  virtualisation = {
    docker.enable = true;
    podman.enable = true;
  };
  users.users.${config.var.username} = {
    extraGroups = ["docker" "podman"];
  };

  # systemd.services.docker = {
  #   serviceConfig = {
  #     Environment = [
  #       "HTTP_PROXY=127.0.0.1:7897"
  #       "HTTPS_PROXY=127.0.0.1:7897"
  # "NO_PROXY=localhost,127.0.0.1,.example.com"
  #     ];
  #   };
  # };
}
