{pkgs, ...}: let
  obsidian-grep = pkgs.writeShellApplication {
    name = "obsidian-grep";
    runtimeInputs = with pkgs; [fzf ripgrep];
    text = ''
      #!/usr/bin/env bash

      BASE_DIR="$HOME/Obsidian"
      VAULT="Obsidian"
      # PATTERN=""

      cd "$BASE_DIR" || {
        echo "Error: Cannot access $BASE_DIR"
        exit 1
      }

      # TODO: Add tag search support
      rg --line-number --color=always "" |
      fzf --ansi \
          --delimiter : \
          --preview 'bat --color=always --highlight-line {2} {1}' \
          --preview-window 'up,+{2}/2' \
          --header $'Enter: open file   Ctrl-O: open in Obsidian Esc: quit' \
          --bind 'enter:execute(xdg-open {1})+abort' \
          --bind "ctrl-o:execute(sh -c 'encoded=\$(printf %s \"{1}\" | sed \"s/ /%20/g\"); xdg-open \"obsidian://open?vault=''${VAULT}&file=\$encoded\"')+abort"
    '';
  };
in {
  home.packages = [obsidian-grep];
}
