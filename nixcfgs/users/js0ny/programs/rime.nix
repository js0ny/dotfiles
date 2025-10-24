{pkgs, ...}: let
  version = "v13.1.3";
  rimeConfig = pkgs.fetchzip {
    url = "https://github.com/amzxyz/rime_wanxiang/releases/download/${version}/rime-wanxiang-zrm-fuzhu.zip";
    sha256 = "sha256-UokSOfGCt7C8/F13BEyy02+rJCqyZcYBWrP/m/Me4D4=";
    stripRoot = false;
  };
  rimePath =
    if pkgs.stdenv.isDarwin
    then "Library/Rime"
    else ".local/share/fcitx5/rime";
in {
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-rime
        kdePackages.fcitx5-configtool
        kdePackages.fcitx5-qt
        fcitx5-gtk
        fcitx5-chinese-addons
      ];
    };
  };
  home.file.${rimePath} = {
    source = rimeConfig;
    recursive = true;
  };
}
