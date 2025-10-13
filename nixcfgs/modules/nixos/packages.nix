# ~/.config/nix-config/common/packages-headless.nix
{ pkgs, ... }:
{
  #  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    tmux
    wl-clipboard
  ];
}
