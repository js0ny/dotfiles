echo "[INFO] Installing Rime"

case "$(uname)" in
  Linux)
    RIMEDIR="${RIMEDIR:-$HOME/.local/share/fcitx5/rime}"
    ;;
  Darwin)
    RIMEDIR="${RIMEDIR:-$HOME/Library/Rime}"
    ;;
esac

git clone --depth 1 https://github.com/js0ny/rime_wanxiang_pro.git "$RIMEDIR"
cd "$RIMEDIR" || exit

just init
# just install_rime
just clone_plum
