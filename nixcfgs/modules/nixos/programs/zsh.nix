{...}: {
  programs.zsh = {
    enable = true;
    histFile = "$XDG_DATA_HOME/zsh/history";
    enableCompletion = true;
    zsh-autoenv.enable = true;
    autosuggestions.enable = true;
  };
  catppuccin.zsh-syntax-highlighting.enable = false;
  environment.pathsToLink = ["/share/zsh"];
}
