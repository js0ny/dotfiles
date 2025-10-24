# TODO
{pkgs}: let
  dictBz2 = [
    {
      url = "http://download.huzheng.org/zh_CN/stardict-langdao-ec-gb-2.4.2.tar.bz2";
      sha256 = "68adfd6348418725b1810b5aeda2506ce44ddbc1ad99f2f68f6ba135cd3bf03c";
    }
  ];
  fetchedArchives = map (spec:
    pkgs.fetchurl {
      url = spec.url;
      sha256 = spec.sha256;
    })
  dictBz2;
in {
  home.packages = with pkgs; [
    sdcv
  ];
}
