{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    powertop
  ];
  imports = [
    ./host-machine.nix
  ];
}
