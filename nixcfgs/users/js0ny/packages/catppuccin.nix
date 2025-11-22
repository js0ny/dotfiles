{pkgs, ...}: let
  my-catppuccin-kde = pkgs.catppuccin-kde.override {
    flavour = [
      "mocha"
      "latte"
    ];
    accents = ["pink"];
    winDecStyles = ["classic"];
  };
in {
  home.packages = with pkgs; [
    catppuccin
    # my-catppuccin-gtk
    my-catppuccin-kde
    catppuccin-fcitx5
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "pink";
  };
}
