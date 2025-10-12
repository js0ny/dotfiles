{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    keyd
  ];

  services.keyd = {
    enable = true;
    keyboards = {
      externalKeyboard = {
        ids = [ "0b05:19b6:d167885d" ]; # ASUS Keyboard
        settings = {
          main = {
            capslock = "overload(control, esc)";
          };
        };
      };
    };
  };
}
