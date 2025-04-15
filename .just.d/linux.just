
[linux]
systemd:
    {{LN}} {{DOTFILES}}/platforms/{{OS}}/systemd {{XDG_CONFIG_HOME}}/systemd

[linux]
keyd:
    -which keyd || sudo pacman -S keyd --noconfirm || sudo apt install keyd --yes || @just build_keyd
    sudo cp {{DOTFILES}}/platforms/linux/keyd/default.conf /etc/keyd/default.conf
    mkdir -p {{XDG_CONFIG_HOME}}/keyd
    {{LN}} {{DOTFILES}}/platforms/linux/keyd/app.conf {{XDG_CONFIG_HOME}}/keyd/app.conf
    sudo systemctl enable --now keyd.service

[linux]
[private]
build_keyd:
    git clone https://github.com/rvaiya/keyd $HOME/.local/build/keyd
    cd $HOME/.local/build/keyd && make && sudo make install

[linux]
flatpak:
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

[linux]
swaylock:
    mkdir -p {{XDG_CONFIG_HOME}}/swaylock
    {{LN}} {{DOTFILES}}/platforms/linux/swaylock {{XDG_CONFIG_HOME}}/swaylock/config

[linux]
dunst:
    mkdir -p {{XDG_CONFIG_HOME}}/dunst
    {{LN}} {{DOTFILES}}/platforms/linux/dunstrc {{XDG_CONFIG_HOME}}/dunst/dunstrc

[linux]
hypr:
    {{LN}} {{DOTFILES}}/platforms/linux/hypr/hyprland/dark.conf {{DOTFILES}}/platforms/linux/hypr/hyprland/current.conf
    {{LN}} {{DOTFILES}}/platforms/linux/hypr {{XDG_CONFIG_HOME}}/hypr

[linux]
rofi:
    {{LN}} {{DOTFILES}}/platforms/linux/rofi/dark.rasi {{DOTFILES}}/platforms/linux/rofi/current.rasi
    {{LN}} {{DOTFILES}}/platforms/linux/rofi {{XDG_CONFIG_HOME}}/rofi

[linux]
waybar:
    {{LN}} {{DOTFILES}}/platforms/linux/waybar {{XDG_CONFIG_HOME}}/waybar
    {{LN}} {{DOTFILES}}/platforms/linux/waybar/dark.css {{DOTFILES}}/platforms/linux/waybar/current.css

[linux]
hyprland:
    @just hypr
    @just dunst
    @just swaylock
    @just rofi


[linux]
fcitx:
    [ -d {{XDG_CONFIG_HOME}}/fcitx5 ] && mv {{XDG_CONFIG_HOME}}/fcitx {{XDG_CONFIG_HOME}}/fcitx5.bak
    {{LN}} {{DOTFILES}}/platforms/linux/fcitx5 {{XDG_CONFIG_HOME}}/fcitx5
