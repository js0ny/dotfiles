{...}: {
  home.file.".magic" = {
    text = ''
      # ---------- Nintendo 3DS CIA ----------
      0       lelong      0x00002020          Nintendo 3DS CTR Importable Archive (CIA)
      !:mime  application/x-ctr-importable-archive
      !:ext   cia

      # ---------- Paradox Mod Descriptor ----------
      0       search/200  supported_version=  Paradox Mod Descriptor
      !:mime  text/x-pdx-descriptor
      !:ext   mod

      0       search/200  tags=               Paradox Mod Descriptor
      !:mime  text/x-pdx-descriptor
      !:ext   mod

      0       search/200  version=            Paradox Mod Descriptor
      !:mime  text/x-pdx-descriptor
      !:ext   mod

      0       search/200  name=               Paradox Mod Descriptor
      !:mime  text/x-pdx-descriptor
      !:ext   mod

      # ---------- Nix Source Code ----------
      0       regex/100   ^[[:space:]]*(\\{|#|let|import) Nix Source Code
      !:mime  text/x-nix
      !:ext   nix
    '';
    force = true;
  };
}
