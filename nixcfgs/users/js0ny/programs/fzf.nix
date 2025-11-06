{...}: let
  editFzfPosix = ''
    edit-fzf() {
        # 1. Declare a variable that is local to the function.
        local _file

        if command -v fd >/dev/null 2>&1; then
            _file=$(fd --type f | fzf --height 40% --reverse -1 -q "$1")
        else
            # Fallback to 'find'
            _file=$(find . -type f | fzf --height 40% --reverse -1 -q "$1")
        fi

        # In POSIX shell, if fzf is cancelled (Esc/Ctrl-C),
        # the command substitution simply returns an empty string.
        # So, we check if the variable '_file' is non-empty ('-n').
        if [ -n "$_file" ]; then
            "$EDITOR" "$_file"
        else
            echo "No file selected."
        fi
    }
    alias ef="edit-fzf"
  '';
in {
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };
  programs.fish.interactiveShellInit = ''
    function edit-fzf --description "Find and edit a file using fzf and $EDITOR"
        set -l file

        if command -q fd
            set file (fd --type f | fzf --height 40% --reverse -1 -q "$argv[1]")
        else
            set file (find . -type f | fzf --height 40% --reverse -1 -q "$argv[1]")
        end

        set -l fzf_status $status

        if test $fzf_status -eq 0; and test -n "$file"
            $EDITOR $file
        else
            echo "No file selected."
        end
    end
    abbr --add ef edit-fzf
  '';
  programs.bash.bashrcExtra = editFzfPosix;
  programs.zsh.initContent = editFzfPosix;
}
