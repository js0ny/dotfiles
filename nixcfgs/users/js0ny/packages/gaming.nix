{pkgs, ...}: {
  home.packages = with pkgs; [
    steam
    # Steam Adwaita Theme
    adwsteamgtk
    # All-in-one Steam and Proton Tools
    steamtinkerlaunch
    # Mimecraft launcher
    prismlauncher
    # Nintendo Switch Emulator
    ryubing
    # WiiU Emulator
    cemu
    # Game launcher and library manager
    lutris

    # Memory Scanner (Cheat Engine Alt.)
    scanmem
  ];
  imports = [
    ../programs/retroarch.nix
  ];
}
