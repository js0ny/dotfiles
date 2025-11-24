{pkgs, ...}: {
  # Use: https://github.com/TemariVirus/fcitx-ini2nix
  i18n.inputMethod =
    if pkgs.stdenv.isDarwin
    then {enable = false;}
    else {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-rime
          kdePackages.fcitx5-configtool
          kdePackages.fcitx5-qt
          fcitx5-gtk
          qt6Packages.fcitx5-chinese-addons
        ];
        settings = {
          "inputMethod" = {
            "Groups/0" = {
              # Group Name
              "Name" = ''Default'';
              # Layout
              "Default Layout" = ''us'';
              # Default Input Method
              "DefaultIM" = ''keyboard-us'';
            };
            "Groups/0/Items/0" = {
              # Name
              "Name" = ''rime'';
              # Layout
              "Layout" = '''';
            };
            "Groups/0/Items/1" = {
              # Name
              "Name" = ''keyboard-us'';
              # Layout
              "Layout" = '''';
            };
            "GroupOrder" = {
              "0" = ''Default'';
            };
          };
          "globalOptions" = {
            "Hotkey" = {
              # Enumerate when holding modifier of Toggle key
              "EnumerateWithTriggerKeys" = ''True'';
              # Temporarily Toggle Input Method
              "AltTriggerKeys" = '''';
              # Skip first input method while enumerating
              "EnumerateSkipFirst" = ''False'';
              # Enumerate Input Method Group Forward
              "EnumerateGroupForwardKeys" = '''';
              # Enumerate Input Method Group Backward
              "EnumerateGroupBackwardKeys" = '''';
              # Time limit in milliseconds for triggering modifier key shortcuts
              "ModifierOnlyKeyTimeout" = ''250'';
            };
            "Hotkey/TriggerKeys" = {
              "0" = ''Zenkaku_Hankaku'';
              "1" = ''Hangul'';
            };
            "Hotkey/ActivateKeys" = {
              "0" = ''Hangul_Hanja'';
            };
            "Hotkey/DeactivateKeys" = {
              "0" = ''Hangul_Romaja'';
            };
            "Hotkey/EnumerateForwardKeys" = {
              "0" = ''Super+space'';
            };
            "Hotkey/EnumerateBackwardKeys" = {
              "0" = ''Shift+Super+space'';
            };
            "Hotkey/PrevPage" = {
              "0" = ''Up'';
            };
            "Hotkey/NextPage" = {
              "0" = ''Down'';
            };
            "Hotkey/PrevCandidate" = {
              "0" = ''Shift+Tab'';
            };
            "Hotkey/NextCandidate" = {
              "0" = ''Tab'';
            };
            "Hotkey/TogglePreedit" = {
              "0" = ''Control+Alt+P'';
            };
            "Behavior" = {
              # Active By Default
              "ActiveByDefault" = ''False'';
              # Reset state on Focus In
              "resetStateWhenFocusIn" = ''No'';
              # Share Input State
              "ShareInputState" = ''No'';
              # Show preedit in application
              "PreeditEnabledByDefault" = ''True'';
              # Show Input Method Information when switch input method
              "ShowInputMethodInformation" = ''True'';
              # Show Input Method Information when changing focus
              "showInputMethodInformationWhenFocusIn" = ''False'';
              # Show compact input method information
              "CompactInputMethodInformation" = ''True'';
              # Show first input method information
              "ShowFirstInputMethodInformation" = ''True'';
              # Default page size
              "DefaultPageSize" = ''5'';
              # Override XKB Option
              "OverrideXkbOption" = ''False'';
              # Custom XKB Option
              "CustomXkbOption" = '''';
              # Force Enabled Addons
              "EnabledAddons" = '''';
              # Force Disabled Addons
              "DisabledAddons" = '''';
              # Preload input method to be used by default
              "PreloadInputMethod" = ''True'';
              # Allow input method in the password field
              "AllowInputMethodForPassword" = ''False'';
              # Show preedit text when typing password
              "ShowPreeditForPassword" = ''False'';
              # Interval of saving user data in minutes
              "AutoSavePeriod" = ''30'';
            };
          };
          "addons" = {
            "clipboard" = {
              "globalSection" = {
                # Trigger Key
                "TriggerKey" = '''';
                # Paste Primary
                "PastePrimaryKey" = '''';
                # Number of entries
                "Number of entries" = ''5'';
                # Do not show password from password managers
                "IgnorePasswordFromPasswordManager" = ''False'';
                # Display passwords as plain text
                "ShowPassword" = ''False'';
                # Seconds before clearing password
                "ClearPasswordAfter" = ''30'';
              };
            };
            "kimpanel" = {
              "globalSection" = {
                # Prefer Text Icon
                "PreferTextIcon" = ''False'';
              };
            };
            "cloudpinyin" = {
              "globalSection" = {
                # Toggle Key
                "Toggle Key" = '''';
                # Minimum Pinyin Length
                "MinimumPinyinLength" = ''4'';
                # Backend
                "Backend" = ''GoogleCN'';
                # Proxy
                "Proxy" = '''';
              };
            };
            "wayland" = {
              "globalSection" = {
                # Allow Overriding System XKB Settings (Only support KDE5+ and GNOME)
                "Allow Overriding System XKB Settings" = ''True'';
              };
            };
            "waylandim" = {
              "globalSection" = {
                # Detect current running application (Need restart)
                "DetectApplication" = ''True'';
                # Forward key event instead of commiting text if it is not handled
                "PreferKeyEvent" = ''True'';
                # Keep virtual keyboard object for V2 Protocol (Need restart)
                "PersistentVirtualKeyboard" = ''False'';
              };
            };
            "rime" = {
              "globalSection" = {
                # Preedit Mode
                "PreeditMode" = ''"Do not show"'';
                # Shared Input State
                "InputState" = ''All'';
                # Fix embedded preedit cursor at the beginning of the preedit
                "PreeditCursorPositionAtBeginning" = ''True'';
                # Action when switching input method
                "SwitchInputMethodBehavior" = ''"Commit commit preview"'';
                # Deploy
                "Deploy" = '''';
                # Synchronize
                "Synchronize" = '''';
              };
            };
            "classicui" = {
              "globalSection" = {
                # Vertical Candidate List
                "Vertical Candidate List" = ''True'';
                # Use mouse wheel to go to prev or next page
                "WheelForPaging" = ''True'';
                # Font
                "Font" = ''"LXGW WenKai Medium 14"'';
                # Menu Font
                "MenuFont" = ''"LXGW WenKai 14"'';
                # Tray Font
                "TrayFont" = ''"Sans Bold 10"'';
                # Tray Label Outline Color
                "TrayOutlineColor" = ''''; #000000
                # Tray Label Text Color
                "TrayTextColor" = ''''; #ffffff
                # Prefer Text Icon
                "PreferTextIcon" = ''False'';
                # Show Layout Name In Icon
                "ShowLayoutNameInIcon" = ''True'';
                # Use input method language to display text
                "UseInputMethodLanguageToDisplayText" = ''True'';
                # Theme
                "Theme" = ''plasma'';
                # Dark Theme
                "DarkTheme" = ''plasma'';
                # Follow system light/dark color scheme
                "UseDarkTheme" = ''True'';
                # Follow system accent color if it is supported by theme and desktop
                "UseAccentColor" = ''True'';
                # Use Per Screen DPI on X11
                "PerScreenDPI" = ''False'';
                # Force font DPI on Wayland
                "ForceWaylandDPI" = ''0'';
                # Enable fractional scale under Wayland
                "EnableFractionalScale" = ''True'';
              };
            };
            "quickphrase" = {
              "globalSection" = {
                # Trigger Key
                "TriggerKey" = '''';
                # Choose key modifier
                "Choose Modifier" = ''None'';
                # Enable Spell check
                "Spell" = ''True'';
                # Fallback Spell check language
                "FallbackSpellLanguage" = ''en'';
              };
            };
            "punctuation" = {
              "globalSection" = {
                # Toggle key
                "Hotkey" = '''';
                # Half width punctuation after latin letter or number
                "HalfWidthPuncAfterLetterOrNumber" = ''True'';
                # Type paired punctuations together (e.g. Quote)
                "TypePairedPunctuationsTogether" = ''False'';
                # Enabled
                "Enabled" = ''True'';
              };
            };
            "chttrans" = {
              "globalSection" = {
                # Translate engine
                "Engine" = ''OpenCC'';
                # Enabled Input Methods
                "EnabledIM" = '''';
                # OpenCC profile for Simplified to Traditional
                "OpenCCS2TProfile" = ''default'';
                # OpenCC profile for Traditional to Simplified
                "OpenCCT2SProfile" = ''default'';
              };
              "sections" = {
                "Hotkey" = {
                  "0" = ''Control+Shift+F'';
                };
              };
            };
            "notifications" = {
              "globalSection" = {
                # Hidden Notifications
                "HiddenNotifications" = '''';
              };
            };
          };
        };
      };
    };
  catppuccin.fcitx5.enable = true;
}
