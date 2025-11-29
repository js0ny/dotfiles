{...}: {
  workspaces = [
    {
      id = 1;
      name = "Master";
      matches = [
        {
          class = "firefox";
        }
      ];
    }
    {
      id = 2;
      name = "Project";
      matches = [
        {
          class = "code|dev.zed.Zed|Vitis IDE|Vivado";
        }
      ];
    }
    {
      id = 3;
      name = "Info";
      matches = [
        {
          class = "discord|thunderbird|QQ|wechat|com.(telegram|ayugram).desktop|io.github.kukuruzka165.materialgram";
        }
      ];
    }
    {
      id = 9;
      name = "Background";
      matches = [
        {
          class = "feishin|Cider";
        }
      ];
    }
  ];
  float-top-right-pin = [
    {
      class = "org.pulseaudio.pavucontrol";
    }
    {
      class = ".bluetooth-manager-wrapped";
    }
  ];
  float-center = [
    {
      class = "com.(telegram|ayugram).desktop";
      title = "Media viewer";
    }
    {
      class = "io.github.kukuruzka165.materialgram";
      title = "Media viewer";
    }
    {
      class = "wechat";
      title = "图片和视频";
    }
    {
      class = "QQ";
      title = "图片查看器";
    }
    {
      class = "QQ";
      title = "群聊的聊天记录";
    }
    {
      class = "CherryStudio";
      title = "Cherry Studio Quick Assistant";
    }
    {
      class = "anki";
      title = "Add";
    }
    {
      class = "kitty-terminal-popup";
    }
    {
      title = "Open File|打开文件|Select a File|选择文件|Choose wallpaper|Open Folder|Save As|保存|Library|File Upload(.*)";
    }
    {
      class = "qt6ct";
    }
  ];
}
