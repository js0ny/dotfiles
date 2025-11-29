{...}: {
  programs.nushell = {
    enable = true;
    shellAliases = {
      "la" = "ls -a";
      "lt" = "lsd --tree";
      "l" = "ls -la";
      "ll" = "ls -lh";
    };
    extraConfig = ''
      $env.config.show_banner = false
    '';
  };
}
