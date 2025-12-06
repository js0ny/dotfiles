{
  pkgs,
  inputs,
  ...
}: {
  virtualisation.waydroid.enable = true;
  nixpkgs.overlays = [
    inputs.nur.overlays.default
  ];
  # waydroid-script: Tool to install libhoudini (arm support), magisk, ...
  # usage: sudo waydroid-script
  environment.systemPackages = with pkgs; [
    nur.repos.ataraxiasjel.waydroid-script
    waydroid-helper
  ];

  networking = {
    firewall.trustedInterfaces = ["waydroid0"];
    nat.enable = true;
  };

  systemd = {
    packages = [pkgs.waydroid-helper];
    services.waydroid-mount = {
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        ExecStart = "${pkgs.waydroid-helper}/bin/waydroid-helper --start-mount";
      };
    };
  };
}
