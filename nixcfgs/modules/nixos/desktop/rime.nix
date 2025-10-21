{pkgs, ...}: {
  # environment.variables = {
  #   GTK_IM_MODULE = "fcitx";
  #   QT_IM_MODULE = "fcitx";
  #   XMODIFIERS = "@im=fcitx";
  #   INPUT_METHOD = "fcitx";
  # };
  i18n.inputMethod = {
    enable = true;
    # enabled = "fcitx5"; dep.
    enableGtk2 = true;
    enableGtk3 = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      # plasma6Support = true;
      addons = with pkgs; [
        fcitx5-rime
        kdePackages.fcitx5-configtool
        kdePackages.fcitx5-qt
        fcitx5-gtk
        fcitx5-lua
      ];
    };
  };
}
