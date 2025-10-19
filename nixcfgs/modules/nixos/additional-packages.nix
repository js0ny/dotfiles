{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    chromium
    nil
    nixd
    libnotify
    imagemagick
  ];
}
