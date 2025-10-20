# ~/.config/nixcfgs/users/js0ny/default.nix
{...}: {
  imports = [
    ./default.nix
    ./packages/cli.nix
    ./packages/gui.nix
    ./packages/flatpak.nix
    ./packages/fonts.nix
    ./packages/catppuccin.nix
    ./programs/chromium.nix
    ./programs/gnome.nix
    ./programs/plasma.nix
    ./programs/shell.nix
    ./programs/vscode.nix
    ./programs/firefox.nix
    ./programs/distrobox.nix
    ./programs/mime.nix
    ./programs/zed-editor.nix
    ./programs/rime.nix
    ../../modules/home/gnome-keyrings.nix
    ../../modules/home/dev/c.nix
    ../../modules/home/dev/go.nix
    ../../modules/home/dev/java.nix
    ../../modules/home/dev/lua.nix
    ../../modules/home/dev/nix.nix
    ../../modules/home/dev/python.nix
    ../../modules/home/programs/eza.nix
    ../../modules/home/programs/winboat.nix
    ../../modules/home/programs/fzf.nix
    ../../modules/home/programs/lsd.nix
    ../../modules/home/programs/nvim.nix
    ../../modules/home/programs/starship.nix
    ../../modules/home/programs/zoxide.nix
  ];

  home.stateVersion = "25.05";
}
