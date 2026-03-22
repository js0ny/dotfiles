{...}: {
  programs.retroarch = {
    enable = true;
    cores = {
      # Nintendo
      # ==================
      mgba.enable = true; # GBA
      desmume.enable = true; # NDS
      citra.enable = true; # 3DS
      mesen.enable = true; # FC
      bsnes.enable = true; # SFC
      mupen64plus.enable = true; # N64
      dolphin.enable = true; # Wii
      # Sony
      # ==================
      swanstation.enable = true; # PS1
      pcsx2.enable = true; # PS2
      ppsspp.enable = true; # PSP
    };
  };
}
