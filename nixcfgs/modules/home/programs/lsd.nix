{pkgs, ...}: {
  programs.lsd = {
    enable = true;
    icons = "always";
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };
}
