{
  config,
  pkgs,
  ...
}: let
  aliasCfg = import ./aliases.nix {pkgs = pkgs;};
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
    shellAliases = aliasCfg.aliases;
    defaultKeymap = "emacs";
    # zsh-abbr = {
    #   enable = true;
    #   abbreviations = aliases;
    # };
    syntaxHighlighting = {
      enable = true;
      patterns = {
        "rm -rf *" = "fg=blue,bold,bg=red";
      };
      styles = {
        path = "fg=cyan,underline";
      };
      highlighters = [
        "main"
        "pattern"
        "brackets"
        "root"
      ];
    };
    initContent = ''
      ${aliasCfg.posixFx}
      # Options
      # ==========

      setopt INTERACTIVE_COMMENTS # Allow comments in interactive mode

      # Globbing
      setopt EXTENDED_GLOB        # Extended globbing
      setopt GLOB_DOTS            # Include dotfiles in globbing

      # Error correction
      setopt CORRECT              # Suggest corrections for commands
      setopt CORRECT_ALL          # Suggest corrections for arguments

      # edit command line
      autoload -Uz edit-command-line
      zle -N edit-command-line

      ### completion
      ### =================

      # use tab to select
      zstyle ':completion:*' menu select

      # substring matching
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

      # use cache
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

      # Colours in completion
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}

      # Complete . and .. special directories
      zstyle ':completion:*' special-dirs true

      # Key bindings (Emacs with modern enhancement)
      # ===============================================

      bindkey '^H' backward-kill-word   # Ctrl-Backspace
      bindkey '^[^?' backward-kill-line # Alt-Backspace

      bindkey '^[[1;5D' backward-word  # Ctrl-Left
      bindkey '^[[1;5C' forward-word   # Ctrl-Right

      bindkey '^[[1;3D' beginning-of-line # Alt-Left
      bindkey '^[[1;3C' end-of-line # Alt-Right


      bindkey '^[[H' beginning-of-line # Home
      bindkey '^[[F' end-of-line       # End


      bindkey '^[[3~' delete-char # Delete
      bindkey '^[[3;5~' kill-word # Ctrl-Delete
      bindkey '^[[3;3~' kill-line # Alt-Delete

      # Misc
      # ========
      # source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
    '';
  };
}
