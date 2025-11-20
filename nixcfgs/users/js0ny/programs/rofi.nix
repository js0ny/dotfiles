{
  pkgs,
  lib,
  config,
  ...
}: let
  catppuccinEnable = config.catppuccin.enable or false;
  catppuccinFlavor = config.catppuccin.flavor or "mocha";
  catppuccinAccent = config.catppuccin.accent or "mauve";
in {
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    plugins = with pkgs; [
      rofimoji
      rofi-power-menu
      rofi-calc
    ];
  };

  # Use this since rasi parsing cannot handle @variable
  # it will add quotes around and break the colour variables.
  xdg.dataFile."rofi/themes/custom.rasi" = lib.mkIf catppuccinEnable {
    enable = true;
    text = lib.mkForce ''
      @theme "catppuccin-default"

      @import "catppuccin-${catppuccinFlavor}"

      * {
        selected-normal-background: @${catppuccinAccent};
      }
    '';
  };

  # The default desktop entry does not have `categories` field, add it manually.
  xdg.desktopEntries = {
    "rofi" = {
      name = "Rofi";
      genericName = "Launcher";
      comment = "A versatile window switcher, application launcher, and dmenu replacement";
      icon = "rofi";
      type = "Application";
      terminal = false;
      categories = [
        "System"
        "Utility"
      ];
      exec = "rofi -show";
    };
    "rofi-theme-selector" = {
      name = "Rofi Theme Selector";
      genericName = "Theme Selector";
      comment = "Select a theme for Rofi";
      icon = "rofi";
      type = "Application";
      terminal = false;
      categories = [
        "System"
        "Utility"
      ];
      exec = "rofi-theme-selector";
    };
  };
}
