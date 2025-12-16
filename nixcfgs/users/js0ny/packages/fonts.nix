{...}: {
  fonts.fontconfig.enable = true;
  fonts.fontconfig = {
    defaultFonts = {
      monospace = [
        "Maple Mono NF CN"
        "JetBrainsMono Nerd Font"
      ];
      serif = [
        "LXGW WenKai"
        "Noto Serif CJK SC"
      ];
      sansSerif = [
        "LXGW Neo XiHei"
        "Noto Sans CJK SC"
      ];
    };
  };
}
