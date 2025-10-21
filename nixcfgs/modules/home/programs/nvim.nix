{...}: let
  alias = {"v" = "nvim";};
in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  programs.fish.shellAbbrs = alias;
  programs.bash.shellAliases = alias;
  programs.zsh.shellAliases = alias;
}
