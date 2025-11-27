{pkgs, ...}: {
  systemd.user.services.hyprpolkitagent = {
    Unit = {
      Description = "Hyprland Polkit Authentication Agent";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
