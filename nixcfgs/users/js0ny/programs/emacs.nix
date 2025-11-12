{pkgs, ...}: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs:
      with epkgs; [
        evil
        evil-leader
        evil-commentary
        evil-surround
        evil-mc
        evil-goggles
        telega
        beancount
        counsel
        company
        vertico
        marginalia
        dirvish
        nix-ts-mode
        flycheck
      ];
  };
  home.packages = with pkgs; [
    tdlib
  ];
}
