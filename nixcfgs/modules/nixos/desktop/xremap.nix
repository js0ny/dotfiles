{...}: let
  _nuphyAir75V2Inputs = [
    "usb-Nordic_Semiconductor_NuPhy_Air75_V2_Dongle-event-kbd"
    "usb-Nordic_Semiconductor_NuPhy_Air75_V2_Dongle-hidraw"
    "usb-Nordic_Semiconductor_NuPhy_Air75_V2_Dongle-if01-event-kbd"
    "usb-Nordic_Semiconductor_NuPhy_Air75_V2_Dongle-if01-event-mouse"
    "usb-Nordic_Semiconductor_NuPhy_Air75_V2_Dongle-if01-hidraw"
    "usb-Nordic_Semiconductor_NuPhy_Air75_V2_Dongle-if01-mouse"
    "usb-Nordic_Semiconductor_NuPhy_Air75_V2_Dongle-if02-hidraw"
    "usb-NuPhy_NuPhy_Air75_V2-event-if01"
    "usb-NuPhy_NuPhy_Air75_V2-event-kbd"
    "usb-NuPhy_NuPhy_Air75_V2-hidraw"
    "usb-NuPhy_NuPhy_Air75_V2-if01-event-joystick"
    "usb-NuPhy_NuPhy_Air75_V2-if01-event-kbd"
    "usb-NuPhy_NuPhy_Air75_V2-if01-event-mouse"
    "usb-NuPhy_NuPhy_Air75_V2-if01-hidraw"
    "usb-NuPhy_NuPhy_Air75_V2-if01-mouse"
    "usb-NuPhy_NuPhy_Air75_V2-if02-hidraw"
  ];
  nuphyAir75V2Inputs = map (name: "/dev/input/by-id/" + name) _nuphyAir75V2Inputs;
in {
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
    withGnome = true;
    # modmap: single key
    serviceMode = "user";
    userName = "js0ny";
    config = {
      modmap = [
        {
          name = "Global";
          device = {
            not = nuphyAir75V2Inputs;
          };
          remap = {
            "KEY_CAPSLOCK" = {
              held = "KEY_LEFTCTRL";
              alone = "KEY_ESC";
              free_hold = true;
            };
          };
        }
        {
          # Mouse Key code:
          # * BTN_EXTRA -> Forward button
          # * BTN_SIDE  -> Back button
          name = "Mouse";
          device = {
            not = nuphyAir75V2Inputs;
          };
          remap = {
            "BTN_EXTRA" = "KEY_ENTER";
          };
        }
      ];
      keymap = [
        {
          name = "IM Navigator - Alt-Up/Down";
          application = {
            only = [
              "wechat"
            ];
          };
          remap = {
            "M-j" = "M-down";
            "M-k" = "M-up";
          };
        }
        {
          name = "IM Navigator - Ctrl-Up/Down";
          application = {
            only = ["QQ"];
          };
          remap = {
            "M-j" = "C-down";
            "M-k" = "C-up";
          };
        }
        {
          name = "Zotero PDF Navigator";
          application = {
            only = ["Zotero"];
          };
          remap = {
            "M-j" = "KEY_PAGEDOWN";
            "M-k" = "KEY_PAGEUP";
          };
        }
      ];
    };
  };

  # treat the virtual keyboard as internal
  # https://github.com/xremap/xremap/discussions/656
  environment.etc."libinput/local-overrides.quirks".text = ''
    [xremap]
    MatchName=xremap
    MatchUdevType=keyboard
    AttrKeyboardIntegration=internal
  '';
}
