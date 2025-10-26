{config, ...}: let
  commonAliases = {
    g = "lazygit";
    ni = "touch";
    cls = "clear";
    ii = "xdg-open";
    aic = "aichat -s";
    aicc = "aichat -c";
    nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles/nixcfgs";
  };
in {
  programs.fish = {
    enable = true;
    interactiveShellInit = "set fish_greeting";
    # preferAbbrs = true;
    shellAbbrs = commonAliases;
  };
  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    shellAliases = commonAliases;
  };
  programs.bash = {
    enable = true;
    shellAliases = commonAliases;
  };
  programs.nushell = {
    enable = true;
    shellAliases = commonAliases;
    extraConfig = ''
      $env.config.show_banner = false
    '';
  };
  programs.zed-editor.extensions = ["fish"];
}
