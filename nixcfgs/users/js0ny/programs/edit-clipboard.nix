{pkgs, ...}: let
  editClipboard = pkgs.writeShellScriptBin "edit-clipboard" ''
    #!/usr/bin/env bash
    # POSIX-compliant edit-clipboard function
    # Reads clipboard content, opens it in $EDITOR, and writes back to clipboard

    edit-clipboard() {
        # Detect clipboard command based on platform
        if command -v pbpaste >/dev/null 2>&1; then
            # macOS
            PASTE_CMD="pbpaste"
            COPY_CMD="pbcopy"
        elif command -v wl-paste >/dev/null 2>&1; then
            # Wayland
            PASTE_CMD="wl-paste"
            COPY_CMD="wl-copy"
        elif command -v xclip >/dev/null 2>&1; then
            # X11 (xclip)
            PASTE_CMD="xclip -selection clipboard -o"
            COPY_CMD="xclip -selection clipboard -i"
        elif command -v xsel >/dev/null 2>&1; then
            # X11 (xsel)
            PASTE_CMD="xsel --clipboard --output"
            COPY_CMD="xsel --clipboard --input"
        else # TODO: Test it on WSL2
            echo "Error: No clipboard utility found" >&2
            echo "Install one of: pbpaste/pbcopy (macOS), wl-clipboard (Wayland), xclip, or xsel (X11)" >&2
            return 1
        fi

        # Create temporary file
        TMPFILE=$(mktemp /tmp/clipboard.XXXXXX) || {
            echo "Error: Failed to create temporary file" >&2
            return 1
        }

        # Read clipboard into temp file
        $PASTE_CMD > "$TMPFILE" || {
            echo "Error: Failed to read from clipboard" >&2
            rm -f "$TMPFILE"
            return 1
        }

        # Open in editor
        "''${EDITOR:-vi}" "$TMPFILE" || {
            echo "Error: Editor exited with error" >&2
            rm -f "$TMPFILE"
            return 1
        }

        # Write back to clipboard
        $COPY_CMD < "$TMPFILE" || {
            echo "Error: Failed to write to clipboard" >&2
            rm -f "$TMPFILE"
            return 1
        }

        # Cleanup
        rm -f "$TMPFILE"
    }

    if [ "''${0##*/}" = "edit-clipboard" ] || [ "''${0##*/}" = "edit-clipboard.sh" ]; then
        edit-clipboard "$@"
    fi
  '';
in {
  home.packages = [editClipboard];
}
