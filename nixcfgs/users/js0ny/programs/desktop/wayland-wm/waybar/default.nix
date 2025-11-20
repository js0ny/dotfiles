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
          /* `otf-font-awesome` is required to be installed for icons */
          font-family: "Font Awesome 7 Free", "JetBrainsMono Nerd Font";
          font-size: 14px;
          font-feature-settings: "tnum";
      }
      #workspaces button:hover {
          background: rgba(0, 0, 0, 0.2);
      }

      #workspaces button.focused {
          background-color: #64727D;
          box-shadow: inset 0 -3px #ffffff;
      }

      #workspaces button.urgent {
          background-color: #eb4d4b;
      }
    '';
  };
}
