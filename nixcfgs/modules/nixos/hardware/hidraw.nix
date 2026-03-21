{...}: {
  services.udev.extraRules = ''
    KERNEL=="hidraw*", ATTRS{idVendor}=="19f5", SUBSYSTEM=="hidraw", GROUP="hidraw", MODE="0660"
  '';

  users.groups.hidraw = {};

  users.users.js0ny = {
    extraGroups = ["hidraw"];
  };
}
