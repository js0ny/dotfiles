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
  imports = [./fcitx.nix];
  home.file.${rimePath} = {
    source = rimeConfigFiltered;
    recursive = true;
  };
  # yaml 最后留出一行
  home.file = {
    "${rimePath}/default.custom.yaml" = {
      text = ''
        patch:
          # 方案列表
          schema_list:
            - schema: wanxiang_pro
            - schema: latex
            - schema: jyut6ping3
            - schema: dioion
            - schema: gekion
          # 切换中英：
          # 不同的选项表示：打字打到一半时按下了 CapsLock、Shift、Control 后：
          # commit_code  上屏原始的编码，然后切换到英文
          # commit_text  上屏拼出的词句，然后切换到英文
          # clear        清除未上屏内容，然后切换到英文
          # inline_ascii 切换到临时英文模式，按回车上屏后回到中文状态
          # noop         屏蔽快捷键，不切换中英，但不要屏蔽 CapsLock
          ascii_composer/switch_key:
            Shift_L: noop
            Shift_R: commit_code
          key_binder/bindings:
            # emacs editing:
            - { when: composing, accept: Control+p, send: Up }
            - { when: composing, accept: Control+n, send: Down }
            - { when: composing, accept: Control+b, send: Left }
            - { when: composing, accept: Control+f, send: Right }

      '';
      enable = true;
    };
    "${rimePath}/wanxiang_pro.custom.yaml" = {
      text = ''
        patch:
          key_binder/sequence:
            pin: "Alt+p" # 使用 Alt-p 而不是 Ctrl-p 置顶候选项（见 ./default.custom.yaml 中 emacs editing）

      '';
      enable = true;
    };
    "${rimePath}/squirrel.custom.yaml" = {
      text = ''
        patch:
          # style/candidate_list_layout: linear
          app_options:
            md.obsidian:
              vim_mode: true
            com.neovide.neovide:
              vim_mode: true
              ascii_mode: true
            com.microsoft.VSCode:
              vim_mode: true
              ascii_mode: true
            com.jetbrains.rider:
              vim_mode: true
              ascii_mode: true
            com.jetbrains.CLion:
              vim_mode: true
              ascii_mode: true
            info.sioyek.sioyek:
              ascii_mode: true
            com.raycast.macos:
              ascii_mode: true
            net.kovidgoyal.kitty:
              ascii_mode: true
              vim_mode: true
            com.mitchellh.ghostty:
              ascii_mode: true
              vim_mode: true
            com.github.wez.wezterm:
              ascii_mode: true
            dev.zed.Zed:
              vim_mode: true
              ascii_mode: true

      '';
      enable = true;
    };
  };

  home.activation.deployRime =
    if pkgs.stdenv.isDarwin
    then
      lib.hm.dag.entryAfter ["writeBoundary"] ''
        /Library/Input\ Methods/Squirrel.app/Contents/MacOS/Squirrel --reload
      ''
    else
      lib.hm.dag.entryAfter ["writeBoundary"] ''
        # ${pkgs.kdePackages.qttools}/bin/qdbus org.fcitx.Fcitx5 /controller org.fcitx.Fcitx.Controller1.SetConfig "fcitx://onfig/addon/rime/deploy" ""
      '';
}
