{...}: let
  zoxideAliases = {
    ".." = "z ..";
    "..." = "z ../..";
    "...." = "z ../../..";
    "....." = "z ../../../..";
    "......" = "z ../../../../..";
  };
in {
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };
  programs.fish.shellAliases = zoxideAliases;
  programs.bash.shellAliases = zoxideAliases;
  programs.zsh.shellAliases = zoxideAliases;
  home.sessionVariables._ZO_EXCLUDE_DIRS = "/sys/*:/nix/*:/dev/*:/tmp/*:/proc/*";
}
