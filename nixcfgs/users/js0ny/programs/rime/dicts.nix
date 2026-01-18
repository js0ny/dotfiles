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

    # # Modify custom_phrase.txt: replace the third line
    # if [ -f $out/custom_phrase.txt ]; then
    #   sed -i '3c\test\tt\t50' $out/custom_phrase.txt
    # else
    #   # If the file doesn't exist, create it with the desired content
    #   echo -e "# Line 1\n# Line 2\ntest\tt\t50" > $out/custom_phrase.txt
    # fi
    # Define custom phrases below
    rm -f $out/custom_phrase.txt

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
    # 感觉用 custom_phrase.txt 更方便一些，用 user.dict.yaml 需要去 base.dict.yaml 里找字
    # 而且适合纯粹汉语拼音输入，不适合通过有独特含义的外文来输入汉字
    "${rimePath}/custom_phrase.txt" = {
      text = builtins.replaceStrings ["\\t"] ["\t"] ''
        #给自定义用户词扩展一个换行:\n, 制表符：\t, 回车符：\r, 空格：\s
        NixOS\tnixos\t1000
        国族\tgozu\t1000
        许珀尔玻瑞亚\txvpoerborvya\t1000
        许珀尔玻瑞亚\thyperborea\t1000
        苏格兰低地\tsugeljdidi\t1000
        英葡联盟\tyypulmmg\t1000
        辉格主义\thvgevuyi\t1000
        伦敦条约\tlpdptcyt\t1000
        凯皮帽\tklpimk\t1000
        凯皮帽\tkepi\t1000
        波拿巴主义\tbonabavuyi\t1000
        华沙曲\thwuaqu\t1000
        华沙曲\thwuaqv\t1000
        阿尔汉格尔斯克\taaerhjgeersike\t1000
        鲁塞尼亚\tluslniya\t1000
        鲁塞尼亚\truthenia\t1000
        喀尔巴阡\tkaerbaqm\t1000
        沃里尼亚\twoliniya\t1000
        切尔克西亚\tqxerkexiya\t1000
        阿斯特拉罕\taasitelahj\t1000
        月即别\tytjibx\t1000
        月即别汗\tytjibxhj\t1000
        月即别\tuzbek\t10
        德左\tdezo\t1000
        捷克军团\tjxkejptr\t1000
        社革党\tuegedh\t1000
        马志尼\tmavini\t1000
        马志尼\tmazzini\t1000
        法团主义\tfatrvuyi\t1000
        法西斯大议会\tfaxisidayihv\t1000
        海间联邦\thljmlmbh\t1000
        昭昭天命\tvkvktmmy\t1000
        天定命运\ttmdymyyp\t1000
        天定命运论\ttmdymyyplp\t1000
        科斯坦丁尼耶\tkesitjdyniye\t1000
        凯末尔\tataturk\t1000
        哈布斯堡-洛林\thabusibkloln\t1000
        魏玛共和国\twzmagshego\t1000
        霍亨索伦\thohgsolp\t1000
        霍亨索伦\thohenzollern\t1000
        梅塞施密特\tmzsluimite\t1000
        里希特霍芬\tlixitehoff\t1000
        安达卢西亚\tandaluxiya\t1000
        安达卢西亚\tandalucia\t1000
        张作相\tvhzoxd\t1000
        张景惠\tvhjyhv\t1000
        庐山声明\tluujugmy\t1000
        近卫文麿\tjnwzwfmo\t1000
        近卫文麿\tjnwzwfmi\t1000
        近卫文麿\tjnwzwfmaro\t1000
        大政翼赞会\tdavgyizjhv\t1000
        八纮一宇\tbahsyiyp\t1000
        昭和维新\tvkhewzxn\t1000
        关特演\tgrteyj\t1000
        关东军特别大演习\tgrdsjptebxdayjxi\t1000
        关东军特种演习\tgrteyj\t900
        零式水侦\tlyuiuvvf\t1000
        水侦\tuvvf\t1000
        舰爆\tjmbk\t1000
        九九舰爆\tjqjqjmbk\t1000
        舰攻\tjmgs\t1000
        九七舰攻\tjqqijmgs\t1000
        歼轰\tjmhs\t1000
        马来之虎\tmallvihu\t1000
        平贺让\tpyherh\t1000
        小泽治三郎\txczevisjlh\t1000
        统制派\ttsvipl\t1000
        荷兰迪亚\theljdiya\t1000
        荷兰迪亚\thollandia\t1000
        驱逐舰\tDD\t1000
        轻巡洋舰\tCL\t1000
        重巡洋舰\tCA\t1000
        战列舰\tBB\t1000
        航空母舰\tCV\t1000
        潜艇\tSS\t1000
        护卫舰\tFF\t1000
        三极管\tBJT\t1000
        场效应管\tFET\t1000
        MOS管\tMOSFET\t1000
        羊陆之交\tyhluvijc\t1000
        小丑牌\tbalatro\t1000
        山海旅探\tujhllvtj\t1000
        此事平平无奇\tciuipypywuqi\t1000
        此事平平无奇\tciui\t1000
      '';
      # 词序有点问题，10 也比默认词典的高，感觉得换成 user.dict.yaml
      # 仏\tfo\t10
      # 広东\tgdds\t10
      # 広州\tgdvb\t10
      # 広西\tgdxi\t10
      # 仏山\tfouj\t10
      enable = true;
    };
    # 一个用 user.dict.yaml 格式写的词典样例，写起来太麻烦了，作者似乎也没弄转换器
    "${rimePath}/user.dict.yaml" = {
      text = ''
        # vim:noexpandtab
        # rime dictionary
        # encoding: utf-8
        ---
        name: misc
        version: "LTS"
        sort: by_weight
        ...
        哈基米  hā;kh jī;tq mǐ;dd 1000
        乌角鲨  wū;pa jiǎo;dy shā;yu 1000
        温都尔汗 wēn;dw dū;ev ěr;xd hán;dg 1000
      '';
    };
  };
}
