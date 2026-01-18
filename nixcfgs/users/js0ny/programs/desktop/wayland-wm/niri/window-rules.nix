# vim:foldmethod=marker
{...}: {
  programs.niri = {
    settings.window-rules = [
      {
        matches = [
          {
            app-id = "^.*terminal-popup$";
          }
          {
            app-id = "^fsearch$";
          }
        ];

        open-floating = true;
        opacity = 0.8;
      }
      {
        matches = [
          {
            app-id = "^org.gnome.NautilusPreviewer$";
          }
          {
            app-id = "^org.gnome.Nautilus$";
            title = "^Select Document$";
          }
          {
            app-id = "^org.gnome.Settings.GlobalShortcutsProvider$";
            title = "^Add Keyboard Shortcuts$";
          }
        ];

        open-floating = true;
      }
      # {{{ float, opacity 0.8, top right: Picture-in-Picture // waybar childs
      {
        matches = [
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
            title = "^Recordings & Screenshots$";
            app-id = "^steam$";
          }
          {
            title = "^Friends List$";
            app-id = "^steam$";
          }
        ];

        open-floating = true;
        opacity = 0.8;
        default-floating-position = {
          x = 50;
          y = 50;
          relative-to = "bottom-right";
        };
      }
      {
        matches = [
          {
            app-id = "^mpv$";
          }
        ];

        default-floating-position = {
          x = 50;
          y = 50;
          relative-to = "bottom-right";
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
          {
            app-id = "^steam$";
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
          # Dolphin file operations
          {
            app-id = "^org.kde.dolphin$";
            title = "^(Copying|Compressing).*$";
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
            title = "^m|Media viewer$";
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
        open-on-workspace = "1-master";
      }
      {
        matches = [
          {app-id = "^code$";}
          {app-id = "^dev.zed.Zed$";}
          {app-id = "^Vitis IDE$";}
          {app-id = "^Vivado$";}
        ];
        open-on-workspace = "2-project";
      }
      {
        matches = [
          {app-id = "^org.kde.krdc$";}
          {app-id = "^org.remmina.Remmina$";}
          {app-id = "^\.virt-manager-wrapped$";}
          {title = "^🌐 ssh.*";}
        ];
        open-on-workspace = "3-alt";
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
        open-on-workspace = "4-info";
      }
      {
        matches = [
          {app-id = "^feishin$";}
          {app-id = "^Cider$";}
        ];
        open-on-workspace = "5-bg";
      }
    ];
  };
}
