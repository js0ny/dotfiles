# This is highly experimental and WIP. Do not use it.
# 2025-11-10 Update:
#   ASUS ROG Zephyrus G14: can redirect GPU
#   TODO: When installing windows, stuck at UEFI Shell
{...}: {
  boot.extraModprobeConfig = ''
    blacklist nouveau
    options nouveau modeset=0
    options vfio-pci ids=10de:28e0,10de:22be
  '';

  boot.kernelParams = [
    "amd_iommu=on"
    "iommu=pt"
    # RTX 4060 Max-Q / Mobile: 10de:28e0
    # AD107 Audio Controller: 10de:22be
    "vfio-pci.ids=10de:28e0,10de:22be"
  ];

  boot.initrd.kernelModules = [
    "vfio-pci"
    "vfio"
    "vfio_iommu_type1"
  ];

  services.xserver.videoDrivers = ["modesetting"];
  boot.blacklistedKernelModules = ["nouveau" "nvidiafb" "nvidia" "nvidia-uvm" "nvidia-drm" "nvidia-modeset"];
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
