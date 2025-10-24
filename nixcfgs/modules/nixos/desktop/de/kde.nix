{pkgs, ...}: {
  services.desktopManager.plasma6.enable = true;
  environment.systemPackages = with pkgs.kdePackages; [
    akonadi
    korganizer
    kdepim-addons
  ];
  services.xserver.desktopManager.cinnamon.enable = true;
}
