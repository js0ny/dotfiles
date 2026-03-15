{...}: {
  programs.firefox.betterfox = {
    enable = true;
    profiles.default.settings = {
      fastfox.enable = true;
      securefox.enable = true;
      peskyfox.enable = true;
    };
  };
}
