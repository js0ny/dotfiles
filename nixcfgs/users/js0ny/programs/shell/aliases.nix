{pkgs}: let
  commonAliases = {
    g = "lazygit";
    ni = "touch";
    cls = "clear";
    aic = "aichat -s";
    aicc = "aichat -c";
    nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles/nixcfgs";
    clip = "wl-copy";
    paste = "wl-paste";
  };
  darwinAliases = {
    reboot = "sudo reboot";
    clip = "pbcopy";
    paste = "pbpaste";
    ii = "open";
    brewi = "brew install";
    brewr = "brew remove";
    brewu = "brew upgrade && brew update";
    brewc = "brew cleanup";
    brewl = "brew list";
  };
  linuxAliases = {
    ii = "xdg-open";
    open = "xdg-open";
  };
in
  commonAliases
  // (
    if pkgs.stdenv.isLinux
    then linuxAliases
    else {}
  )
  // (
    if pkgs.stdenv.isDarwin
    then darwinAliases
    else {}
  )
