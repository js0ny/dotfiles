{...}: {
  hardware.uinput.enable = true;
  boot.kernelModules = ["uinput"];
  services.udev.extraRules = ''
    KERNEL=="uinput", GROUP="input", TAG+="uaccess"
  '';
  users.users.js0ny.extraGroups = ["input" "uinput"];
}
