{pkgs}: let
  commonAliases = {
    ni = "touch";
    cls = "clear";
    aic = "aichat -s";
    aicc = "aichat -c";
    nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles/nixcfgs";
    clip = "wl-copy";
    paste = "wl-paste";
    ipy = "nix run 'nixpkgs#python313Packages.ipython'"; # IPython
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
  posixFx = ''
    mt() {
      mkdir -p $(dirname $1) && touch $1
    }
    mtv() {
      mkdir -p $(dirname $1) && touch $1 && nvim $1
    }
  '';
  fishFx = ''
    function mt
        mkdir -p (dirname $argv[1]) && touch $argv[1]
    end

    function mtv
        mkdir -p (dirname $argv[1]) && touch $argv[1] && nvim $argv[1]
    end
  '';
in {
  aliases =
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
    );
  inherit posixFx fishFx;
}
