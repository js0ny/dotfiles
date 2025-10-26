{pkgs, ...}: let
  dictBz2 = [
    {
      #  朗道英汉字典
      url = "http://download.huzheng.org/zh_CN/stardict-langdao-ec-gb-2.4.2.tar.bz2";
      sha256 = "68adfd6348418725b1810b5aeda2506ce44ddbc1ad99f2f68f6ba135cd3bf03c";
    }
    {
      #  朗道汉英字典
      url = "http://download.huzheng.org/zh_CN/stardict-langdao-ce-gb-2.4.2.tar.bz2";
      sha256 = "d539239f4920aa308582fba53918ea16844b6a2378cb74f9b99bfaec6e2f4f30";
    }
  ];

  fetchedArchives = map (spec:
    pkgs.fetchurl {
      url = spec.url;
      sha256 = spec.sha256;
    })
  dictBz2;

  stardict-dicts = pkgs.stdenv.mkDerivation {
    name = "stardict-dictionaries-combined";
    srcs = fetchedArchives;
    sourceRoot = ".";

    installPhase = ''
      mkdir -p $out
      for src in $srcs; do
        tar -xjvf $src -C $out --strip-components=1
      done
    '';
  };
in {
  home.packages = with pkgs; [
    sdcv
  ];

  home.file.".local/share/stardict/dic" = {
    source = stardict-dicts;
  };
}
