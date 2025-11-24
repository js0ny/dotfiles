# ~/.config/nix-config/common/packages-headless.nix
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    tmux
    file
    unzip
    zip
  ];
}
