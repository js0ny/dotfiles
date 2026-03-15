{pkgs, ...}: let
  volume-notify = pkgs.writeShellApplication {
    name = "volume-notify";

    runtimeInputs = with pkgs; [
      wireplumber
      gawk
      gnugrep
      libnotify
    ];

    text = ''
      if [ $# -eq 0 ]; then
          echo "Usage: volume-notify {up|down|mute}"
          exit 1
      fi

      case "$1" in
          up)
              wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+
              ;;
          down)
              wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-
              ;;
          mute)
              wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
              ;;
          *)
              echo "Invalid argument: $1"
              exit 1
              ;;
      esac

      if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q 'MUTED'; then
          TEXT="Volume: Muted"
      else
          VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}')
          TEXT="Volume: ''${VOLUME}%"
      fi

      notify-send -h string:x-canonical-private-synchronous:volume -t 1500 "🔊 Audio" "$TEXT"
    '';
  };
in {
  home.packages = [volume-notify];
}
