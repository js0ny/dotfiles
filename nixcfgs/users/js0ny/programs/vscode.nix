{
  pkgs,
  config,
  ...
}: let
  codeAlias = {"c" = "code";};
  codeReleasesConfigDir = [
    "Code"
    "VSCodium"
    "Antigravity"
  ];
in {
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

  # Remove default snippet dir before running this to avoid conflicts
  xdg.configFile = builtins.listToAttrs (map (dir: {
      name = "${dir}/User/snippets";
      value = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/lsp-snippets/snippets";
        force = true;
        # recursive = true;
      };
    })
    codeReleasesConfigDir);

  catppuccin.vscode.profiles.default.enable = false;
  programs.fish.shellAbbrs = codeAlias;
  programs.bash.shellAliases = codeAlias;
  programs.zsh.shellAliases = codeAlias;
}
