# ~/.config/nixcfgs/hosts/polder/default.nix
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # impure build
    /etc/nixos/hardware-configuration.nix
    ../../modules/nixos
  ];
  system.stateVersion = "25.05";

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.kernelParams = ["console=ttyS0,115200n8" "console=tty0"];
  boot.loader.grub.useOSProber = true;
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  time.timeZone = "Etc/UTC";

  nixpkgs.config.allowUnfree = true;
  networking.hostName = "polder";

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
    };
  };

  networking = {
    usePredictableInterfaceNames = false;
    interfaces.eth0.ipv4.addresses = [
      {
        address = "158.220.98.103";
        prefixLength = 20;
      }
    ];
    defaultGateway = {
      address = "158.220.96.1";
      interface = "eth0";
    };
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
      "2606:4700:4700::1111"
      "2001:4860:4860::8888"
    ];
    firewall = {
      enable = true;
      allowedTCPPorts = [22];
    };
  };
  environment.systemPackages = with pkgs; [
    rclone
  ];
}
