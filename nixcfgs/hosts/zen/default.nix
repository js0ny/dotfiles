{pkgs, ...}: {
  imports = [
    ./packages.nix
    ./brew.nix
    ./dock.nix
    ./system.nix
  ];
  time.timeZone = "Europe/London";

  services.tailscale.enable = true;
}
