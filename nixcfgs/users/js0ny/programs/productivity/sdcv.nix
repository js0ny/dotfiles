{pkgs, ...}: let
  dictSources = [
    {
      # 朗道英汉字典
      url = "http://download.huzheng.org/zh_CN/stardict-langdao-ec-gb-2.4.2.tar.bz2";
      sha256 = "68adfd6348418725b1810b5aeda2506ce44ddbc1ad99f2f68f6ba135cd3bf03c";
    }
    {
      # 朗道汉英字典
      url = "http://download.huzheng.org/zh_CN/stardict-langdao-ce-gb-2.4.2.tar.bz2";
      sha256 = "d539239f4920aa308582fba53918ea16844b6a2378cb74f9b99bfaec6e2f4f30";
    }
    {
      # ECDICT (The Ultimate Dictionary)
      url = "https://github.com/skywind3000/ECDICT/releases/download/1.0.28/ecdict-stardict-28.zip";
      sha256 = "sha256-xwfQ897W7Hm5ZGbaShV04HRwPaWvnBIPutl/nLCMbyw=";
    }
  ];

  fetchedArchives = map (spec:
    pkgs.fetchurl {
      url = spec.url;
      sha256 = spec.sha256;
    })
  dictSources;

  stardict-dicts = pkgs.stdenv.mkDerivation {
    name = "stardict-dictionaries-combined";
    srcs = fetchedArchives;
    sourceRoot = ".";

    # 需要 unzip 来解压 zip 文件
    nativeBuildInputs = [pkgs.unzip];

    installPhase = ''
      mkdir -p $out
      for src in $srcs; do
        if [[ "$src" == *.zip ]]; then
          # zip 文件直接解压到输出目录 (保留原有文件夹结构)
          unzip $src -d $out
        else
          # tar.bz2 文件解压并剥离第一层目录 (兼容旧逻辑)
          tar -xjvf $src -C $out --strip-components=1
        fi
      done
    '';
  };

  # See: https://github.com/Dushistov/sdcv/issues/107
  fzfSdcv = pkgs.writeShellScriptBin "sdcv-fzf" ''
    fzf --prompt="Dict: " \
        --phony \
        --bind "enter:reload(sdcv {q} -n --json | jq '.[].dict' -r)" \
        --preview "sdcv {q} -en --use-dict={}" \
        --preview-window=wrap \
       < <(echo)
  '';
in {
  home.packages = with pkgs; [
    sdcv
    fzfSdcv
  ];

  xdg.dataFile."stardict/dic" = {
    source = stardict-dicts;
  };
}
