{
  pkgs,
  lib,
  ...
}: let
  version = "v13.3.12";
  rimeWanxiang = pkgs.fetchzip {
    url = "https://github.com/amzxyz/rime_wanxiang/releases/download/${version}/rime-wanxiang-zrm-fuzhu.zip";
    # sha256 = lib.fakeHash;
    sha256 = "sha256-vnhg+//ByZmQ2uxBZTn3cDYKrUFckLAuU8MfB8kSDVA=";
    stripRoot = false;
  };

  rimeCantonese = pkgs.fetchFromGitHub {
    owner = "rime";
    repo = "rime-cantonese";
    rev = "69615390ccb65736186f5cb76b32bed365fd18ed";
    sha256 = "sha256-vkE+kag5ZXwJwlGBWCTDZkP00h4/XwanpK1aChj+S2o=";
  };

  rimeTeochew = pkgs.fetchFromGitHub {
    owner = "kahaani";
    repo = "dieghv";
    rev = "1709bb786a144de7be2229755011fde9034457de";
    sha256 = "sha256-rMViEO0nxNEjVZbHwB0e9vSpe5TfHV7CuJoouS84Pjg=";
  };

  rimeLatex = pkgs.fetchFromGitHub {
    owner = "shenlebantongying";
    repo = "rime_latex";
    rev = "858f2abc645f0e459e468e98122470ce20b16b30";
    sha256 = "sha256-i8Rgze+tQhbE+nl+JSj09ILXeUvf6MOS9Eqsuqis1n0=";
  };

  rimeLatexFiltered = pkgs.runCommand "rime-latex-filtered" {} ''
    cp -r ${rimeLatex} $out
    chmod -R u+w $out

    find $out -name "*.md" -type f -delete
    rm -rf $out/.scripts
    rm -f $out/LICENSE # GPLv3
  '';

  rimeTeochewFiltered = pkgs.runCommand "rime-teochew-filtered" {} ''
    cp -r ${rimeTeochew} $out
    chmod -R u+w $out

    find $out -name "*.md" -type f -delete
  '';

  # Filter rime-cantonese: remove .md files and unwanted directories
  rimeCantoneseFiltered = pkgs.runCommand "rime-cantonese-filtered" {} ''
    cp -r ${rimeCantonese} $out
    chmod -R u+w $out

    # Remove unwanted directories
    rm -rf $out/.ci
    rm -rf $out/.github
    rm -rf $out/demo

    # Remove all .md files
    find $out -name "*.md" -type f -delete
  '';

  # Create a modified version of rimeWanxiang with custom_phrase.txt modifications
  # and merge with rime-cantonese
  rimeConfigFiltered = pkgs.runCommand "rime-config-filtered" {} ''
    cp -r ${rimeWanxiang} $out
    chmod -R u+w $out

    # Modify custom_phrase.txt: replace the third line
    if [ -f $out/custom_phrase.txt ]; then
      sed -i '3c\test\tt\t50' $out/custom_phrase.txt
    else
      # If the file doesn't exist, create it with the desired content
      echo -e "# Line 1\n# Line 2\ntest\tt\t50" > $out/custom_phrase.txt
    fi

    # Merge rime files
    cp -r ${rimeCantoneseFiltered}/* $out/
    cp -r ${rimeTeochewFiltered}/* $out/
    cp -r ${rimeLatexFiltered}/* $out/
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
  home.file.${rimePath} = {
    source = rimeConfigFiltered;
    recursive = true;
  };
  home.file."${rimePath}/default.custom.yaml" = {
    text = ''
      patch:
        schema_list:
          - schema: wanxiang_pro
          - schema: latex
          - schema: jyut6ping3
          - schema: dioion
          - schema: gekion

    '';
    enable = true;
  };
}
