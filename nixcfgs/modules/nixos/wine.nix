# https://nixos.wiki/wiki/Wine
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wineWowPackages.stable
    winetricks
    wineWowPackages.waylandFull
  ];
}
