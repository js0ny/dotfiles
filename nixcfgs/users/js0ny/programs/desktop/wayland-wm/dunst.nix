{lib, ...}: {
  services.dunst.enable = true;
  systemd.user.services.dunst = {
    Install.WantedBy = lib.mkForce ["niri.service"];
    Service = {
      # Disable on KDE
      ExecCondition = lib.mkForce ''
        /bin/sh -c '[ "$XDG_CURRENT_DESKTOP" != "KDE" ] && [ "$XDG_CURRENT_DESKTOP" != "Plasma" ]'
      '';
    };
  };
}
