{ pkgs, ... }:
{

  home.packages = with pkgs; [
    freerdp
    winboat
  ];
}
