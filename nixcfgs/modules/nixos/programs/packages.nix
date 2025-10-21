{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nil
    nixd
    libnotify
    imagemagick
  ];
}
