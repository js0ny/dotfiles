{...}: let
  nvimAlias = {"v" = "nvim";};
in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  programs.fish.shellAbbrs = nvimAlias;
  programs.bash.shellAliases = nvimAlias;
  programs.zsh.shellAliases = nvimAlias;
  programs.nushell.shellAliases = nvimAlias;
}
