{pkgs, ...}: {
  home.packages = with pkgs; [beets];
  programs.beets = {
    enable = false;
    settings = {
      plugins = ["rewrite"];
    };
  };
}
