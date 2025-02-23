echo "[INFO] Installing AppMan"
echo "[ACTION] Type [2] to install AppMan"
wget -q https://raw.githubusercontent.com/ivan-hc/AM/main/AM-INSTALLER && chmod a+x ./AM-INSTALLER && ./AM-INSTALLER

if command -v appman >/dev/null 2>&1; then
    appman install wezterm
    appman install nvim
fi
