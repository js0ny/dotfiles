{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    asusctl
    supergfxctl
  ];

  services.asusd.enable = true;
  services.supergfxd.enable = true;
}
