{pkgs, ...}: {
  home.packages = with pkgs; [
    protontricks
    bottles
    lutris
  ];
}
