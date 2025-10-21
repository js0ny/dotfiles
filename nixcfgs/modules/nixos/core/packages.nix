# ~/.config/nix-config/common/packages-headless.nix
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    tmux
    nix-index
    file
    unzip
    zip
    pkg-config
  ];
}
