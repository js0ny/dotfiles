{...}: {
  fonts.fontconfig.enable = true;
  fonts.fontconfig = {
    defaultFonts = {
      monospace = [
        "Maple Mono NF CN"
        "JetBrainsMono Nerd Font"
      ];
      serif = ["LXGW WenKai"];
      sansSerif = ["LXGW Neo XiHei"];
    };
  };
}
