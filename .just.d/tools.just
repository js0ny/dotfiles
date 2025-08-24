[unix]
kitty:
    which kitty
    {{LN}} {{DOTFILES}}/tools/kitty {{XDG_CONFIG_HOME}}/kitty

neovim:
    which nvim
    {{LN}} {{DOTFILES}}/tools/nvim {{XDG_CONFIG_HOME}}/nvim
    nvim --headless +checkhealth +"w nvim-healthcheck.txt" +qall

nvim:
    @just neovim

[linux]
bash:
    {{LN}} {{DOTFILES}}/tools/bash {{XDG_CONFIG_HOME}}/bash
    sudo cp {{DOTFILES}}/tools/bash/xdg-compat.sh /etc/profile.d/xdg-compat.sh

[unix]
fish:
    {{LN}} {{DOTFILES}}/tools/fish {{XDG_CONFIG_HOME}}/fish
    {{CURL}} https://raw.githubusercontent.com/SpaceAceMonkey/dotenv-for-fish/refs/heads/main/dotenv.fish {{CURL_OUT}} "{{DOTFILES}}/tools/fish/functions/dotenv.fish"

[unix]
screen:
    {{LN}} {{DOTFILES}}/tools/screen {{XDG_CONFIG_HOME}}/screen

[unix]
tmux:
    {{LN}} {{DOTFILES}}/tools/tmux {{XDG_CONFIG_HOME}}/tmux

thunderbird:
    {{CURL}} https://github.com/wshanks/tbkeys/releases/download/v2.4.0/tbkeys.xpi {{CURL_OUT}} "$HOME/Downloads/tbkeys.xpi"
    {{CURL}} https://github.com/htyxyt/htyxyt-immersive-translate-Thunderbird/releases/download/thunderbird-v1.14.8/immersive-translate-Thunderbird.v1.14.8.xpi {{CURL_OUT}} "$HOME/Downloads/immersive-translate-Thunderbird.xpi"
    {{CURL}} https://raw.githubusercontent.com/catppuccin/thunderbird/refs/heads/main/themes/mocha/mocha-lavender.xpi {{CURL_OUT}} "$HOME/Downloads/thunderbird-dark.xpi"
    cat {{DOTFILES}}/tools/thunderbird/tbkeys.json | {{CLIP}}

wezterm:
    which wezterm
    {{LN}} {{DOTFILES}}/tools/wezterm {{XDG_CONFIG_HOME}}/wezterm


yazi:
    which yazi || cargo install --locked yazi-fm yazi-cli
    -ya pack -a llanosrocas/yaziline
    -ya pack -a yazi-rs/plugins:git
    -ya pack -a Rolv-Apneseth/starship

[unix]
zsh:
    -[[ -f /etc/zshenv ]] && sudo cp {{DOTFILES}}/tools/zsh/global.zshenv /etc/zshenv # or /etc/zsh/zshenv
    -[[ -f /etc/zsh/zshenv ]] && sudo cp {{DOTFILES}}/tools/zsh/global.zshenv /etc/zsh/zshenv
    mkdir -p {{XDG_CONFIG_HOME}}/zsh
    {{LN}} {{DOTFILES}}/tools/zsh/zshenv {{XDG_CONFIG_HOME}}/zsh/.zshenv
    {{LN}} {{DOTFILES}}/tools/zsh/zshrc {{XDG_CONFIG_HOME}}/zsh/.zshrc
    {{LN}} {{DOTFILES}}/tools/zsh/zprofile {{XDG_CONFIG_HOME}}/zsh/.zprofile
    test -d {{XDG_CONFIG_HOME}}/zsh/plugins/zsh-autosuggestions || git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git {{XDG_CONFIG_HOME}}/zsh/plugins/zsh-autosuggestions
    test -d {{XDG_CONFIG_HOME}}/zsh/plugins/zsh-syntax-highlighting || git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git {{XDG_CONFIG_HOME}}/zsh/plugins/zsh-syntax-highlighting
    test -d {{XDG_CONFIG_HOME}}/zsh/plugins/zsh-history-substring-search || git clone --depth 1 https://github.com/zsh-users/zsh-history-substring-search.git {{XDG_CONFIG_HOME}}/zsh/plugins/zsh-history-substring-search
    test -d {{XDG_CONFIG_HOME}}/zsh/plugins/zsh-completions || git clone --depth 1 https://github.com/zsh-users/zsh-completions.git {{XDG_CONFIG_HOME}}/zsh/plugins/zsh-completions

[linux]
install_emacs:
    git clone --depth 1 https://github.com/emacs-mirror/emacs.git --branch feature/igc $HOME/.local/build/emacs-igc-build
    cd $HOME/.local/build/emacs-igc-build
    ./autogen.sh
    ./configure --with-mailutils --with-native-compilation --with-pgtk --with-tree-sitter --with-imagemagick
    make -j$(nproc)
    sudo make install
