{
  pkgs,
  lib,
  ...
}: let
  highlightJs = pkgs.fetchurl {
    url = "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/es/highlight.min.js";
    sha256 = "sha256-eGWDmUnwdk2eCiHjEaTixCYz7q7oyl7BJ7hkOFZXMf4=";
  };
in {
  # Currently, copyous is not in nixpkgs.
  home.packages = with pkgs; [
    libgda6
    gsound
  ];
  xdg.dataFile."copyous@boerdereinar.dev/highlight.min.js".source = highlightJs;
  dconf.settings = {
    # TODO: Add more settings here later.
    "org/gnome/shell/extensions/copyous" = {
      open-clipboard-dialog-shortcut = ["<Super>v"];
      show-at-pointer = true;
    };
  };
}
