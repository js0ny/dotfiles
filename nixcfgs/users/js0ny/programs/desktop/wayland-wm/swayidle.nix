{pkgs, ...}: {
  services.swayidle = {
    enable = true;
    systemdTarget = "waylandwm-session.target";
    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.hyprlock}/bin/hyprlock";
      }
      {
        timeout = 600;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
}
