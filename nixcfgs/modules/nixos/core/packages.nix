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
# Explicitly define default EDITOR
  programs.nano.enable = false;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
  };
}
