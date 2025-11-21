{
  pkgs,
  lib,
  config,
  ...
}: let
  catppuccinEnable = config.catppuccin.enable or false;
  catppuccinFlavor = config.catppuccin.flavor or "mocha";
  catppuccinAccent = config.catppuccin.accent or "mauve";
  # https://github.com/sentriz/cliphist/blob/master/contrib/cliphist-rofi-img
  cliphistRofiImg = pkgs.writeShellScriptBin "cliphist-rofi-img" ''
    #!/usr/bin/env bash

    tmp_dir="/tmp/cliphist"
    rm -rf "$tmp_dir"

    if [[ -n "$1" ]]; then
        cliphist decode <<<"$1" | wl-copy
        exit
    fi

    mkdir -p "$tmp_dir"

    read -r -d "" prog <<EOF
    /^[0-9]+\s<meta http-equiv=/ { next }
    match(\$0, /^([0-9]+)\s(\[\[\s)?binary.*(jpg|jpeg|png|bmp)/, grp) {
        system("echo " grp[1] "\\\\\t | cliphist decode >$tmp_dir/"grp[1]"."grp[3])
        print \$0"\0icon\x1f$tmp_dir/"grp[1]"."grp[3]
        next
    }
    1
    EOF
    cliphist list | gawk "$prog"
  '';
in {
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    plugins = with pkgs; [
      rofimoji
      rofi-power-menu
      rofi-calc
      rofi-obsidian
      cliphistRofiImg
    ];
    modes = [
      "run"
      "ssh"
      {
        name = "clipboard";
        path = lib.getExe cliphistRofiImg;
      }
      "drun"
      "window"
      "combi"
      "calc"
      # {
      #   name = "obsidian";
      #   path = lib.getExe pkgs.rofi-obsidian;
      # }
      {
        name = "emoji";
        path = lib.getExe pkgs.rofimoji;
      }
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
