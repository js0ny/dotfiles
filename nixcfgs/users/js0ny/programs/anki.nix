{pkgs, ...}: {
  home.sessionVariables.ANKI_WAYLAND = 1;
  programs.anki = {
    enable = true;
    addons = with pkgs.ankiAddons; [
      anki-connect
      review-heatmap
      recolor
    ];
  };
}
