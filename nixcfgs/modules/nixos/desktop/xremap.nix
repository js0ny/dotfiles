{...}: {
  imports = [
    ../hardware/uinput.nix
  ];

  # Keycode: https://github.com/emberian/evdev/blob/1d020f11b283b0648427a2844b6b980f1a268221/src/scancodes.rs#L15
  # Alias for mods:
  #     SHIFT-
  #     CTRL-, C-, CONTROL-
  #     ALT-, M-
  #     WIN-, SUPER-, WINDOWS-

  services.xremap = {
    enable = true;
    withNiri = true;
    # modmap: single key
    serviceMode = "user";
    userName = "js0ny";
    config = {
      modmap = [
        {
          name = "Global";
          device = {
            not = [
              ### QMK Keyboards
              # Nuphy Air 75 V2
              "/dev/input/by-id/usb-Nordic_Semiconductor_NuPhy_Air75_V2_Dongle-if01-event-kbd"
              "/dev/input/by-id/usb-Nordic_Semiconductor_NuPhy_Air75_V2_Dongle-event-kbd"
              "/dev/input/by-id/usb-Nordic_Semiconductor_NuPhy_Air75_V2_Dongle-if01-event-mouse"
            ];
          };
          remap = {
            "KEY_CAPSLOCK" = {
              held = "KEY_LEFTCTRL";
              alone = "KEY_ESC";
              free_hold = true;
            };
          };
        }
      ];
      keymap = [
        {
          name = "IM Navigator - Alt-Up/Down";
          application = {
            only = ["org.telegram.desktop" "telegram-desktop" "wechat"];
          };
          remap = {
            "M-j" = "M-down";
            "M-k" = "M-up";
          };
        }
        {
          name = "IM Navigator - Ctrl-Up/Down";
          application = {
            only = ["qq"];
          };
          remap = {
            "M-j" = "C-down";
            "M-k" = "C-up";
          };
        }
        {
          name = "Zotero PDF Navigator";
          application = {
            only = ["zotero"];
          };
          remap = {
            "M-j" = "KEY_PAGEDOWN";
            "M-k" = "KEY_PAGEUP";
          };
        }
      ];
    };
  };
}
