{pkgs, ...}: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        user = "js0ny";
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd 'uwsm start hyprland'";
      };
    };
  };
}
