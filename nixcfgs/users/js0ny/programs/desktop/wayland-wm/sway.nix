# See also: ~/.dotfiles/home/dot_config/sway
# https://d19qhx4ioawdt7.cloudfront.net/docs/nix-home-manager-sway.html
{
  lib,
  pkgs,
  ...
}: let
  mod = "Mod4";
in {
  wayland.windowManager.sway = {
    checkConfig = true;
    # config = {
    #   modifier = mod;
    #   keybindings = lib.attrsets.mergeAttrsList [
    #     (lib.attrsets.mergeAttrsList (map (num: let
    #       ws = toString num;
    #     in {
    #       "${mod}+${ws}" = "workspace ${ws}";
    #       "${mod}+Ctrl+${ws}" = "move container to workspace ${ws}";
    #     }) [1 2 3 4 5 6 7 8 9 0]))
    #
    #     (lib.attrsets.concatMapAttrs (key: direction: {
    #         "${mod}+${key}" = "focus ${direction}";
    #         "${mod}+Ctrl+${key}" = "move ${direction}";
    #       }) {
    #         h = "left";
    #         j = "down";
    #         k = "up";
    #         l = "right";
    #       })
    #   ];
    # };
    swaynag.enable = true;
  };

  home.packages = with pkgs; [
    grim
    slurp
    sway-contrib.grimshot
  ];

  imports = [
    ./packages.nix
  ];
}
