{
  config,
  pkgs,
  ...
}: let
  aliases = import ./aliases.nix {pkgs = pkgs;};
in {
  home.packages = with pkgs; [
    zsh-fzf-tab
  ];
  programs.zsh = {
    enable = true;
    autocd = true;
    # oh-my-zsh.enable = true;
    autosuggestion.enable = true;
    historySubstringSearch.enable = true;
    enableCompletion = true;
    dotDir = "${config.xdg.configHome}/zsh";
    shellAliases = aliases;
    defaultKeymap = "emacs";
    syntaxHighlighting = {
      enable = true;
      patterns = {
        "rm -rf *" = "fg=blue,bold,bg=red";
      };
      highlighters = [
        "main"
        "pattern"
        "brackets"
        "root"
      ];
    };
    initContent = ''
      # # Emacs Hybrid
      # bindkey '^A' beginning-of-line
      # bindkey '^E' end-of-line
      # bindkey '^F' forward-char
      # bindkey '^B' backward-char
      # bindkey '^P' up-line-or-history
      # bindkey '^N' down-line-or-history
      # # bindkey '^R' history-incremental-search-backward # Use fzf
      # bindkey '^K' kill-line
      #
      # bindkey -M viins '^?' backward-delete-char
      # bindkey -M viins '^H' backward-kill-word
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|=*'

      # fzf-tab 模糊匹配
      zstyle ':fzf-tab:*' use-fzf-default-bindings yes
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
    '';
  };
}
