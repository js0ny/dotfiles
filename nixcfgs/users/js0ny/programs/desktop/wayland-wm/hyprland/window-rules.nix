{...}: {
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      # windowrule = match:class mpv, float on, move (monitor_w-20-window_w) (monitor_h-20-window_h), pin on
    ];
    windowrulev2 = [
      "suppressevent maximize, class:.*"
      # Right Bottom
      "float, pin, size 25%, move 73% 73%, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
      "float, pin, size 25%, move 73% 73%, title:^(画中画)(.*)$"

      # Right Top
      "float, pin, size 25%, move 73% 10%, class:^(org.pulseaudio.pavucontrol)$"
      # Right Top + no focus
      "noinitialfocus, float, pin, size 25%, move 73% 10%, class:^(org.kde.(dolphin|ark))$, title:^(Extracting|Compressing)(.*)$"
      "noinitialfocus, float, pin, size 25%, move 73% 10%, class:^(thunar)$, title:^(File Operation Progress)$"
      # Centered
      "float, center, size 50%, class:^(com.(telegram|ayugram).desktop)$, title:^(Media viewer)$"
      "float, center, size 50%, class:^(io.github.kukuruzka165.materialgram)$, title:^(Media viewer)$"
      "float, center, size 50%, class:^(wechat)$, title:^(图片和视频)$"
      "float, center, size 50%, class:^(QQ)$, title:^(图片查看器)$"
      "float, center, size 50%, class:^(QQ)$, title:^(群聊的聊天记录)$"
      "float, center, size 50%, class:^(CherryStudio)$, title:^(Cherry Studio Quick Assistant)$"
      "float, center, size 50%, class:^(anki)$, title:^(Add)$"
      "float, center, size 50%, class:^(kitty-terminal-popup)$"
      "float, center, title:^(Open File|打开文件|Select a File|选择文件|Choose wallpaper|Open Folder|Save As|保存|Library|File Upload)(.*)$"
      "float, center, class:^(qt6ct)$"
      # no focus
      "float, noinitialfocus, center, class:^(gimp)$, title:^(GIMP Startup)$"
      "float, noinitialfocus, center, class:^(wechat)$, title:^(wechat)$"
      # Pin + Stay focused
      "float, pin, stayfocused, class:^(rofi)$"

      # Workspace 1 - Master
      "workspace 1, class:^(firefox)$"
      # Workspace 2 - Project
      "workspace 2, class:^(code|dev.zed.Zed|Vitis IDE|Vivado)$"
      # Workspace 3 - Info
      "workspace 3, class:^(discord|thunderbird|QQ|wechat|com.(telegram|ayugram).desktop|io.github.kukuruzka165.materialgram)$"
      # Workspace 9 - Background
      "workspace 9, class:^(feishin|Cider)$"
    ];
  };
}
