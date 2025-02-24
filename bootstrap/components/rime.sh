echo "[INFO] Installing Rime"

git clone --depth 1 https://github.com/js0ny/rime_wanxiang_pro.git ~/Library/Rime
cd ~/Library/Rime

just init
# just install_rime
## Rime is installed via Brewfile
just clone_plum
