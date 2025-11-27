{pkgs, ...}: {
  imports = [./modules.nix];
  home.packages = with pkgs; [
    pavucontrol
    font-awesome
  ];
  services.blueman-applet.enable = true;
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
    style = ''
      * {
          font-family: "LXGW Neo XiHei", "Font Awesome 7 Free", "JetBrainsMono Nerd Font";
          font-size: 14px;
          font-feature-settings: "tnum";
      }
    '';

    #   window#waybar {
    #       background-color: @base;
    #       padding: 0px;
    #   }
    #
    #   #workspaces {
    #       color: #f0f0ff;
    #       background-color: rgba(30, 30, 46, 0.6);
    #   }
    #
    #   #workspaces button:hover {
    #       background: @pink;
    #   }
    #
    #   #workspaces button.urgent {
    #       background-color: @red;
    #   }
    #
    #
    #   #custom-osicon {
    #       color: @blue;
    #       padding: 0 6px;
    #   }
    #
    #   #clock,
    #   #tray,
    #   #battery,
    #   #cpu,
    #   #memory,
    #   #disk,
    #   #temperature,
    #   #backlight,
    #   #network,
    #   #pulseaudio,
    #   #wireplumber,
    #   #custom-media,
    #   #mode,
    #   #idle_inhibitor,
    #   #scratchpad,
    #   #mpd {
    #       padding: 0 10px;
    #       color: @text;
    #       background-color: @base;
    #   }
    # '';
  };
}
