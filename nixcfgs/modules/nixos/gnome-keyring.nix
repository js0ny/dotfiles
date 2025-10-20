{pkgs, ...}: {
  programs.gnupg.agent.enableSSHSupport = false;
  services.gnome.gnome-keyring.enable = true;
  services.gnome.gcr-ssh-agent.enable = true;
  programs.seahorse.enable = true;
  programs.ssh = {
    enableAskPassword = true;
    askPassword = "${pkgs.seahorse}/libexec/seahorse/askpass";
  };
  environment.systemPackages = with pkgs; [
    seahorse
  ];
}
