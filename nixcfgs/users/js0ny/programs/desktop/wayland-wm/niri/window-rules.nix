# vim:foldmethod=marker
{...}: {
  programs.niri = {
    settings.window-rules = [
      # {{{ float, opacity 0.8, top right: Picture-in-Picture // waybar childs
      {
        matches = [
          {
            app-id = "^firefox$";
            title = "^Picture-in-Picture$";
          }
          {
            # Applies to all chromium
            title = "^Picture in picture$";
          }
          {
            app-id = "^org.pulseaudio.pavucontrol$";
            title = "^Volume Control$";
          }
        ];

        open-floating = true;
        opacity = 0.8;
        default-floating-position = {
          x = 50;
          y = 50;
          relative-to = "top-right";
        };
      }
      # }}}
      {
        matches = [
          {
            app-id = "^gimp$";
            title = "^GIMP Startup$";
          }
          {
            # Generic wechat floating window
            app-id = "^wechat$";
            title = "^wechat$";
          }
        ];
        open-focused = false;
      }
      {
        matches = [
          {
            app-id = "^org.kde.(ark|dolphin)$";
            title = "^Extracting";
          }
        ];
        open-focused = false;
        default-floating-position = {
          x = 50;
          y = 50;
          relative-to = "top-right";
        };
      }
      {
        matches = [
          # Anki add new flashcard
          {
            app-id = "^anki$";
            title = "^Add$";
          }
          # Dolphin compressing files
          {
            app-id = "^org.kde.dolphin$";
            title = "^Compressing.*$";
          }
          {
            app-id = "^thunar$";
            title = "^File Operation Progress$";
          }
          ### IM Medias
          {
            app-id = "^QQ$";
            title = "^图片查看器$";
          }
          {
            app-id = "^QQ$";
            title = "^群聊的聊天记录$";
          }
          {
            app-id = "^org.telegram.desktop$";
            title = "^Media viewer$";
          }
          {
            app-id = "^com.ayugram.desktop$";
            title = "^Media viewer$";
          }
          {
            app-id = "^io.github.kukuruzka165.materialgram$";
            title = "^Media viewer$";
          }
          {
            app-id = "^wechat$";
            title = "^图片和视频$";
          }
          {
            app-id = "^CherryStudio$";
            title = "^Cherry Studio Quick Assistant$";
          }
        ];
        open-floating = true;
      }
      {
        matches = [
          {app-id = "^firefox$";}
        ];
        open-on-workspace = "master";
      }
      {
        matches = [
          {app-id = "^code$";}
          {app-id = "^dev.zed.Zed$";}
          {app-id = "^Vitis IDE$";}
          {app-id = "^Vivado$";}
        ];
        open-on-workspace = "project";
      }
      {
        matches = [
          {app-id = "^org.kde.krdc$";}
          {app-id = "^\.virt-manager-wrapped$";}
          {title = "^🌐 ssh.*";}
        ];
        open-on-workspace = "remote";
      }
      {
        matches = [
          {app-id = "^org.telegram.desktop$";}
          {app-id = "^io.github.kukuruzka165.materialgram$";}
          {app-id = "^com.ayugram.desktop$";}
          {app-id = "^wechat$";}
          {app-id = "^QQ$";}
          {app-id = "^discord$";}
          {app-id = "^thunderbird$";}
        ];
        open-on-workspace = "info";
      }
      {
        matches = [
          {app-id = "^feishin$";}
          {app-id = "^Cider$";}
        ];
        open-on-workspace = "bg";
      }
    ];
  };
}
