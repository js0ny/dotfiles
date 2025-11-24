{config, ...}: {
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    # powerManagement.finegrained = true;
    # prime = {
    #   offload.enable = true;
    # };
  };
  services.xserver.videoDrivers = ["nvidia"];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.ollama.acceleration = "cuda";
}
