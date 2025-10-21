{pkgs, ...}: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs:
      with epkgs; [
        evil
        telega
        beancount
        counsel
      ];
  };
  home.packages = with pkgs; [
    tdlib
  ];
}
