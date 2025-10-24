{pkgs, ...}: {
  programs.zed-editor = {
    enable = true;
    extensions = [
      "dockerfile"
      "catppuccin"
      "toml"
      "material-icon-theme"
      "git-firefly"
      "make"
    ];
  };
}
