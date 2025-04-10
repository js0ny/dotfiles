
[linux]
systemd:
    ln -sf {{DOTFILES}}/platforms/{{OS}}/systemd {{XDG_CONFIG_HOME}}/systemd/

[linux]
keyd:
    -which keyd || sudo pacman -S keyd --noconfirm || sudo apt install keyd --yes || @just build_keyd
    sudo cp {{DOTFILES}}/platforms/linux/keyd/keyd.conf /etc/keyd/default.conf
    mkdir -p {{XDG_CONFIG_HOME}}/keyd
    {{LN}} {{DOTFILES}}/platforms/linux/keyd/app.conf {{XDG_CONFIG_HOME}}/keyd/app.conf
    sudo systemctl enable keyd

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
    {{LN}} {{DOTFILES}}/platforms/linux/hypr {{XDG_CONFIG_HOME}}/hypr

[linux]
rofi:
    {{LN}} {{DOTFILES}}/platforms/linux/rofi {{XDG_CONFIG_HOME}}/rofi

[linux]
hyprland:
    @just hypr
    @just dunst
    @just swaylock
    @just rofi


