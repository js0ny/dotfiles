{pkgs, ...}: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # caelestia-shell
    xdg-desktop-portal-hyprland
    hyprpolkitagent
  ];
}
