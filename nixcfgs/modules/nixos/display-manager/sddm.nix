{pkgs, ...}: {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    extraPackages = with pkgs; [
      sddm-astronaut
    ];
    # theme = "sddm-astronaut-theme";
  };
}
