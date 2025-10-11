# ~/.config/nixcfgs/users/js0ny/default.nix
{
  pkgs,
  nix-flatpak,
  plasma-manager,
  ...
}: {
  imports = [
    ./packages/cli.nix
    ./packages/gui.nix
    ./packages/flatpak.nix
    ./programs/chromium.nix
    ./programs/gnome.nix
    ./programs/plasma.nix
    ./programs/shell.nix
    ./programs/vscodium.nix
    ./programs/git.nix
    ../../modules/home/dev/java.nix
    ../../modules/home/dev/nix.nix
    ../../modules/home/dev/python.nix
    ../../modules/home/programs/eza.nix
    ../../modules/home/programs/fzf.nix
    ../../modules/home/programs/lsd.nix
    ../../modules/home/programs/nvim.nix
    ../../modules/home/programs/rime.nix
    ../../modules/home/programs/starship.nix
    ../../modules/home/programs/zed-editor.nix
    ../../modules/home/programs/zoxide.nix
    # ./flatpak.nix
  ];
  home.username = "js0ny";
  home.homeDirectory = "/home/js0ny";

  home.packages = with pkgs; [
    home-manager
    gcr
  ];

  services.gnome-keyring.enable = true;

  xdg.mimeApps = {
    defaultApplications = {
      "application/pdf" = "org.kde.okular.desktop";
    };
  };

  home.stateVersion = "25.05";
}
