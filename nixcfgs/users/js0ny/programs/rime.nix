{
  pkgs,
  lib,
  ...
}: let
  version = "v13.3.12";
  rimeConfig = pkgs.fetchzip {
    url = "https://github.com/amzxyz/rime_wanxiang/releases/download/${version}/rime-wanxiang-zrm-fuzhu.zip";
    # sha256 = lib.fakeHash;
    sha256 = "sha256-vnhg+//ByZmQ2uxBZTn3cDYKrUFckLAuU8MfB8kSDVA=";
    stripRoot = false;
  };

  # Create a modified version of rimeConfig without custom_phrase.txt
  rimeConfigFiltered = pkgs.runCommand "rime-config-filtered" {} ''
    cp -r ${rimeConfig} $out
    chmod -R u+w $out
    rm -f $out/custom_phrase.txt
  '';

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
        qt6Packages.fcitx5-chinese-addons
      ];
    };
  };
  home.file = {
    ${rimePath} = {
      source = rimeConfigFiltered;
      recursive = true;
    };
    "${rimePath}/custom_phrase.txt".text = "";
  };
}
