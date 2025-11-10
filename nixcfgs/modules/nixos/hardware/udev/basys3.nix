{config, ...}: {
  # Xilinx Artix-7 Basys 3
  # See: https://www.devicekb.com/hardware/usb-vendors/vid_0403-pid_6010
  services.udev.extraRules = ''
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", MODE="0660", GROUP="dialout", SYMLINK+="basys3"
  '';
  users.users.js0ny = {
    extraGroups = ["dialout"];
  };
}
