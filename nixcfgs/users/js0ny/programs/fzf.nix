{pkgs, ...}: let
  edit-fzf = pkgs.writeShellApplication {
    name = "edit-fzf";
    runtimeInputs = with pkgs; [fzf];
    text = ''
      _file=""

      if command -v fd >/dev/null 2>&1; then
          _file=$(fd --type f --exclude '*.lock' | fzf --height 40% --reverse -1 -q "''${1:-}")
      else
          # Fallback to 'find'
          _file=$(find . -type f ! -name '*.lock' | fzf --height 40% --reverse -1 -q "''${1:-}")
      fi

      # In POSIX shell, if fzf is cancelled (Esc/Ctrl-C),
      # the command substitution simply returns an empty string.
      # So, we check if the variable '_file' is non-empty ('-n').
      if [ -n "$_file" ]; then
          "$EDITOR" "$_file"
      else
          echo "No file selected."
      fi
    '';
  };
in {
  home.packages = [edit-fzf];
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };
  programs = {
    bash.shellAliases = {
      ef = "edit-fzf";
    };
    zsh.shellAliases = {
      ef = "edit-fzf";
    };
    fish.shellAbbrs = {
      ef = "edit-fzf";
    };
  };
}
