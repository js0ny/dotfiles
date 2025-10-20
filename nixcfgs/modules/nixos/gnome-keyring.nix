{pkgs, ...}: {
  services.gnome.gnome-keyring.enable = true;
  services.gnome.gcr-ssh-agent.enable = true;
  programs.ssh = {
    enableAskPassword = true;
  };
}
