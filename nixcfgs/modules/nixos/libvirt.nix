{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    virt-manager
    dnsmasq
    virtiofsd
  ];
  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd
        ];
      };
    };
  };
  users.users.js0ny = {
    extraGroups = ["libvirtd"];
  };
  networking.firewall.trustedInterfaces = ["virbr0"];
  virtualisation.spiceUSBRedirection.enable = true;
}
