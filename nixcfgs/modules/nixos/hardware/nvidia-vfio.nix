# This is highly experimental and WIP. Do not use it.
{...}: {
  boot.extraModprobeConfig = ''
    blacklist nouveau
    options nouveau modeset=0
  '';

  services.xserver.videoDrivers = ["modesetting"];
  boot.blacklistedKernelModules = ["nouveau" "nvidia" "nvidia_drm" "nvidia_modeset"];
  hardware.nvidia = {
    # enable = false;
    modesetting.enable = false;
    powerManagement.enable = false;
  };
  # Enable ssh to solve issues temporarily
  services.openssh = {
    enable = true;
    settings = {
      UseDns = true;
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };
}
