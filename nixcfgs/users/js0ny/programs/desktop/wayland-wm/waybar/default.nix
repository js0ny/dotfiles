{pkgs, ...}: {
  imports = [./modules.nix];
  home.packages = with pkgs; [
    pavucontrol
    font-awesome
  ];
  services.blueman-applet.enable = true;
  programs.waybar = {
    enable = true;
    style = ''
      * {
          font-family: "Font Awesome 7 Free", "JetBrainsMono Nerd Font";
          font-size: 14px;
          font-feature-settings: "tnum";
      }
      #workspaces button:hover {
          background: @pink;
      }

      #workspaces button.urgent {
          background-color: @red;
      }
    '';
  };
}
