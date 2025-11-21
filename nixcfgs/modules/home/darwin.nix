{
  lib,
  pkgs,
  ...
}: {
  home.sessionPath = ["/opt/homebrew/bin"];

  programs.nh = {
    enable = true;
    flake = "/Users/js0ny/.dotfiles/nixcfgs";
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 5 --keep-since 3d";
    };
  };

  xdg.desktopEntries = lib.mkForce {};

  i18n.inputMethod.enable = false;

  programs.ghostty.systemd.enable = false;
  programs.ghostty.package = pkgs.ghostty-bin;
}
