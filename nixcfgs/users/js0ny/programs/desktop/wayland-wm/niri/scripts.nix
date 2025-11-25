# Stolen from basecamp/omarchy
{pkgs, ...}: {
  focusOrLaunch = pkgs.writeShellApplication {
    name = "nirictl-focus-or-launch";

    runtimeInputs = [pkgs.jq pkgs.niri];

    text = ''

      if (($# == 0)); then
        echo "Usage: $0 <app_id> <command-to-launch>" >&2
        exit 1
      fi

      APP_ID="$1"
      CMD="''${2:-$1}"

      WINDOWS=$(niri msg --json windows)

      TARGET_ID=$(echo "$WINDOWS" | jq -r ".[] | select(.app_id == \"$APP_ID\") | .id" | head -n 1)

      if [ -n "$TARGET_ID" ]; then
        niri msg action focus-window --id "$TARGET_ID"
      else
        eval "$CMD" &
      fi
    '';
  };
}
