{...}: {
  # Disable for now, currently trying xremap and katana
  services.keyd = {
    enable = false;
    keyboards = {
      externalKeyboard = {
        ids = ["0b05:19b6:d167885d"]; # ASUS Keyboard
        settings = {
          main = {
            capslock = "overload(control, esc)";
          };
        };
      };
    };
  };
  # See https://github.com/rvaiya/keyd?tab=readme-ov-file#faqs
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Serial Keyboards]
    MatchUdevType=keyboard
    MatchName=keyd*keyboard
    AttrKeyboardIntegration=internal
  '';
}
