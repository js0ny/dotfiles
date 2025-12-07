{pkgs, ...}: let
  dailyNote = pkgs.writeShellScriptBin "daily-note" ''
    VAULT_DIR="$HOME/Obsidian/00 - Journal/Daily"
    DATE_STR=$(date +%Y-%m-%d)
    FILE_PATH="$VAULT_DIR/$DATE_STR.md"

    if [ ! -d "$VAULT_DIR" ]; then
      mkdir -p "$VAULT_DIR"
    fi

    if [ ! -f "$FILE_PATH" ]; then
      echo "# $DATE_STR" > "$FILE_PATH"
      echo "" >> "$FILE_PATH"
      echo "## Highlights" >> "$FILE_PATH"
      echo "" >> "$FILE_PATH"
      echo "## Log" >> "$FILE_PATH"
      echo "" >> "$FILE_PATH"
      echo "- $(date +%H:%M) " >> "$FILE_PATH"
    fi

    nvim + "$FILE_PATH"
  '';
in {
  imports = [
    ./vimrc-support.nix
    ./obsidian-grep.nix
  ];
  programs.obsidian = {
    enable = false;
    vaults."HomeManagerDryRun" = {
      enable = true;
      target = "HomeManagerDryRun"; # relative to $HOME
      settings = {
      };
    };
  };
  home.packages = [
    dailyNote
  ];
  programs = {
    bash.shellAliases = {
      dn = "daily-note";
    };
    zsh.shellAliases = {
      dn = "daily-note";
    };
    fish.shellAbbrs = {
      dn = "daily-note";
    };
  };
}
