{pkgs, ...}: {
  home.packages = with pkgs; [
    kdePackages.yakuake
    krunner-vscodeprojects
    jetbrains-runner
  ];
  programs.plasma = {
    enable = true;
    session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
    fonts = {
      fixedWidth.family = "Maple Mono NF";
      fixedWidth.pointSize = 10;
      general.family = "LXGW Neo XiHei";
      general.pointSize = 10;
    };
    krunner = {
      position = "center";
    };
    workspace = {
      iconTheme = "Papirus";
      colorScheme = "BreezeDark";
    };
    kwin = {
      virtualDesktops.number = 8;
      titlebarButtons = {
        left = [
          "more-window-actions"
          "on-all-desktops"
          "keep-above-windows"
        ];
      };
    };
    shortcuts = {
      yakuake = {
        "toggle-window-state" = "Meta+`";
      };
    };
    input.touchpads = [
      {
        disableWhileTyping = true;
        enable = true;
        leftHanded = true;
        middleButtonEmulation = true;
        name = "ASUP1208:00 093A:3011 Touchpad";
        productId = "3011";
        vendorId = "093A";
        naturalScroll = true;
        pointerSpeed = 0;
        tapToClick = true;
        accelerationProfile = "none";
        scrollSpeed = 0.15;
      }
    ];

    panels = [
      # Windows-like panel at the bottom
      {
        location = "bottom";
        widgets = [
          # "org.kde.plasma.kickoff"
          {
            name = "org.kde.plasma.kickoff";
            config = {
              General = {
                icon = "distributor-logo-nixos";
                alphaSort = true;
              };
            };
          }
          {
            name = "org.kde.plasma.icontasks";
            config = {
              General = {
                launchers = [
                  "applications:org.kde.dolphin.desktop"
                  "applications:firefox.desktop"
                  "applications:com.mitchellh.ghostty.desktop"
                ];
              };
            };
          }
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemtray"
          {
            name = "org.kde.plasma.digitalclock";
            config = {
              Appearance = {
                dateFormat = "isoDate";
                enabledCalendarPlugins = "alternatecalendar,holidaysevents";
                firstDayOfWeek = 1;
                selectedTimeZones = "Local,Asia/Shanghai,Europe/London";
                showSeconds = "Always";
                showWeekNumbers = true;
                use24hFormat = 2;
              };
            };
          }
          "org.kde.plasma.showdesktop"
        ];
      }
      # Global menu at the top
      {
        location = "top";
        height = 20;
        widgets = [
          "org.kde.plasma.pager"
          "org.kde.plasma.windowlist"
          "org.kde.plasma.marginsseparator"
        ];
        opacity = "translucent";
        hiding = "none";
      }
    ];
  };
  programs.okular = {
    enable = true;
    accessibility.changeColors.mode = "InvertLightness";
    general.mouseMode = "TextSelect";
  };
  programs.kate.enable = true;
  programs.kate.editor = {
    font = {
      family = "Maple Mono NF";
      pointSize = 10;
    };
    inputMode = "vi";
  };
  programs.konsole = {
    enable = true;
    defaultProfile = "Default";
    profiles = {
      Default = {
        command = "${pkgs.fish}/bin/fish";
        colorScheme = "Breeze";
        font = {
          name = "Maple Mono NF";
          size = 12;
        };
      };
    };
  };
}
