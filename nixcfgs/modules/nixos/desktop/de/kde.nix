{pkgs, ...}: {
  services.desktopManager.plasma6.enable = true;
  environment.systemPackages = with pkgs.kdePackages; [
    akonadi
    korganizer
    kdepim-addons
  ];
  # NOTE: Upstream does not support running withKDE as root
  services.xremap = {
    serviceMode = "user";
    userName = "js0ny";
  };
}
