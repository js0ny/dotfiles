# vim:foldmethod=marker,
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
            app-id = "^wechat$";
            title = "^图片和视频$";
          }
        ];
        open-floating = true;
      }
    ];
  };
}
