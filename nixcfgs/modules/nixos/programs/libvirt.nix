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
    };
    onShutdown = "shutdown";
    onBoot = "ignore";
  };
  users.users.js0ny = {
    extraGroups = ["libvirtd"];
  };
  networking.firewall.trustedInterfaces = ["virbr0"];
  virtualisation.spiceUSBRedirection.enable = true;
}
