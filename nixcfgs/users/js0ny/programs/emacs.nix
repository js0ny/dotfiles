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
        highlight-indent-guides
        magit
      ];
  };
  # TODO: tdlib version is too high
  # See: https://github.com/zevlg/telega.el/issues/374
  home.packages = with pkgs; [
    tdlib
  ];
}
