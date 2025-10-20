{ pkgs, ... }:
let
  my-catppuccin-kde = pkgs.catppuccin-kde.override {
    flavour = [
      "mocha"
      "latte"
    ];
    accents = [ "pink" ];
    winDecStyles = [ "classic" ];
  };
  my-catppuccin-gtk = pkgs.catppuccin-gtk.override {
    accents = [ "pink" ];
    variant = "mocha";
  };
in
{

  home.packages = with pkgs; [
    catppuccin
    my-catppuccin-gtk
    my-catppuccin-kde
    catppuccin-fcitx5
  ];
}
