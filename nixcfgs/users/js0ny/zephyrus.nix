# ~/.config/nixcfgs/users/js0ny/default.nix
{
  pkgs,
  nix-flatpak,
  plasma-manager,
  ...
}:
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
  imports = [
    ./default.nix
    ./packages/cli.nix
    ./packages/gui.nix
    ./packages/flatpak.nix
    ./packages/fonts.nix
    ./programs/chromium.nix
    ./programs/gnome.nix
    ./programs/plasma.nix
    ./programs/shell.nix
    ./programs/vscode.nix
    ./programs/git.nix
    ./programs/firefox.nix
    ./programs/distrobox.nix
    ./programs/mime.nix
    ./programs/zed-editor.nix
    # ./programs/floorp.nix
    ../../modules/home/gnome-keyrings.nix
    ../../modules/home/dev/c.nix
    ../../modules/home/dev/java.nix
    ../../modules/home/dev/lua.nix
    ../../modules/home/dev/nix.nix
    ../../modules/home/dev/python.nix
    ../../modules/home/programs/eza.nix
    ../../modules/home/programs/fzf.nix
    ../../modules/home/programs/lsd.nix
    ../../modules/home/programs/nvim.nix
    ../../modules/home/programs/starship.nix
    ../../modules/home/programs/zoxide.nix
    # ./flatpak.nix
  ];

  home.packages = with pkgs; [
    catppuccin
    my-catppuccin-gtk
    my-catppuccin-kde
    catppuccin-fcitx5
    freerdp
    winboat
  ];

  home.stateVersion = "25.05";
}
