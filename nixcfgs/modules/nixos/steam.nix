{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    fontPackages = with pkgs; [
      lxgw-neoxihei
    ];
  };
}
