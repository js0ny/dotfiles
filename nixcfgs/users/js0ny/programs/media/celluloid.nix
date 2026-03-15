{
  pkgs,
  config,
  ...
}: {
  # MPV GTK4 frontend
  imports = [./mpv.nix]; # Include MPV configuration
  home.packages = [pkgs.celluloid];
  dconf.settings = {
    "io/github/celluloid-player/celluloid" = {
      mpv-config-enable = true;
      mpv-input-config-enable = true;
      mpv-config-file = "file:///home/${config.home.username}/.config/mpv/mpv.conf";
      mpv-input-config-file = "file:///home/${config.home.username}/.config/mpv/input.conf";
    };
  };
}
