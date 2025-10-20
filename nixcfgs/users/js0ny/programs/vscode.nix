{pkgs, ...}: {
  programs.vscode = {
    package = pkgs.vscode;
    enable = true;
  };

  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-extensions; [
      golang.go
      vscodevim.vim
      pkief.material-icon-theme
      catppuccin.catppuccin-vsc
      vspacecode.vspacecode
      vspacecode.whichkey
    ];
  };
}
