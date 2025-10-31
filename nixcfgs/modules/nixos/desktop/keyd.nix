{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    keyd
  ];

  services.keyd = {
    enable = true;
    keyboards = {
      ids = ["*"];
      settings = {
        main = {
          capslock = "overload(control, esc)";
        };
      };
    };
  };
}
