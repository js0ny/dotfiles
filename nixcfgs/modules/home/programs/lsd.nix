{pkgs, ...}: {
  programs.lsd = {
    enable = true;
    colors = "always";
    icons = "always";
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };
}

