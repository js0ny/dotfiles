{pkgs, ...}: {
  networking.nftables = {
    enable = true;
  };
  networking.firewall.backend = "nftables";

  environment.systemPackages = with pkgs; [
    iptables-nftables-compat
  ];
}
