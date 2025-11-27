{pkgs, ...}: let
  #   swayidleWrapper = pkgs.writeShellScriptBin "swayidle-wrapper" ''
  #     ${pkgs.swayidle}/bin/swayidle -w \
  #              timeout 300 'swaylock -f' \
  #              timeout 600 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' \
  #              before-sleep 'swaylock -f -c 000000'
  #   '';
  powerprofiles-next = pkgs.writeShellScriptBin "powerprofiles-next" ''
    #!/usr/bin/env bash

    CURRENT_PROFILE=$(${pkgs.power-profiles-daemon}/bin/powerprofilesctl get)

    case $CURRENT_PROFILE in
        "power-saver")
            NEXT_PROFILE="balanced"
            ICON="power-profile-balanced-symbolic"
            ;;
        "balanced")
            NEXT_PROFILE="performance"
            ICON="power-profile-performance-symbolic"
            ;;
        "performance" | *)
            NEXT_PROFILE="power-saver"
            ICON="power-profile-power-saver-symbolic"
            ;;
    esac

    ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set $NEXT_PROFILE

    echo "Power profile set to: $NEXT_PROFILE"

    ${pkgs.libnotify}/bin/notify-send -a "powerprofilesctl" "Power Profile" "$NEXT_PROFILE" -i $ICON -u low -t 2000
  '';
in {
  imports = [
    ../../walker.nix
    ./waybar
    ./swww.nix
    ./kanshi.nix
    ./swaylock.nix
    ./polkit.nix
  ];
  home.packages = with pkgs; [
    swayidle # Screensaver
    cliphist # Clipboard daemon
    # swayidleWrapper
    brightnessctl
    playerctl
    powerprofiles-next
    blueman
  ];
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [xdg-desktop-portal-wlr xdg-desktop-portal-gtk];
  };
  services.cliphist.enable = true;
  services.dunst.enable = true;
  services.network-manager-applet.enable = true;
  catppuccin.dunst.enable = false;
}
