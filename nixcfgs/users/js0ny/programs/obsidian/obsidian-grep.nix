{pkgs, ...}: {
  obsidian-grep = pkgs.writeShellApplication {
    name = "obsidian-grep";
    runtimeInputs = with pkgs; [fzf rg];
    text = ''
      #!/usr/bin/env bash

      BASE_DIR="$HOME/Obsidian"
      VAULT="Obsidian"
      # PATTERN="''${1:-ob}"

      cd "$BASE_DIR" || {
        echo "Error: Cannot access $BASE_DIR"
        exit 1
      }

      rg --line-number --color=always "" |
      fzf --ansi \
          --delimiter : \
          --preview 'bat --color=always --highlight-line {2} {1}' \
          --preview-window 'up,+{2}/2' \
          --header $'Enter: open file   Ctrl-O: open in Obsidian   Ctrl-T: Tag search   Esc: quit' \
          --bind 'enter:execute(xdg-open {1})+abort' \
          --bind "ctrl-o:execute(sh -c 'encoded=\$(printf %s \"{1}\" | sed \"s/ /%20/g\"); xdg-open \"obsidian://open?vault=''${VAULT}&file=\$encoded\"')+abort"
    '';
  };
}
