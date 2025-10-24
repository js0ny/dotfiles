{pkgs, ...}:
# See https://www.reddit.com/r/NixOS/comments/1kcj34p/how_to_apply_this_sddm_theme_on_nixos/
let
  custom-sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "astronaut";
    #themeConfig = {
    #  Background = "path/to/background.jpg";
    #  Font = "M+1 Nerd Font";
    #};
  };
in {
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
    enable = true;
    extraPackages = with pkgs; [
      custom-sddm-astronaut
    ];

    theme = "sddm-astronaut-theme";
    settings = {
      Theme = {
        Current = "sddm-astronaut-theme";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    custom-sddm-astronaut
    kdePackages.qtmultimedia
  ];
}
