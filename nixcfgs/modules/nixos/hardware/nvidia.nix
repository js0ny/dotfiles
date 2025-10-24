{
  hardware.nvidia = {
    open = false;
  };
  services.xserver.videoDrivers = ["nvidia"];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
