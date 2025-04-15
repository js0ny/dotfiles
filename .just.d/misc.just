uv:
    uv init {{XDG_DATA_HOME}}/uvenv
    cd {{XDG_DATA_HOME}}/uvenv
    uv venv
    uv add -r {{DOTFILES}}/bootstrap/components/requirements.txt

vivaldi:
    {{CURL}} https://github.com/catppuccin/vivaldi/releases/download/1.0.0-ctpv2/Catppuccin.Latte.Lavender.zip {{CURL_OUT}} "$HOME/Downloads/vivaldi-light.zip" # Catppuccin Latte Lavender
    {{CURL}} https://github.com/catppuccin/vivaldi/releases/download/1.0.0-ctpv2/Catppuccin.Mocha.Lavender.zip {{CURL_OUT}} "$HOME/Downloads/vivaldi-dark.zip" # Catppuccin Mocha Lavender


zotero:
    {{CURL}} https://github.com/syt2/zotero-addons/releases/download/V1.8.1/zotero-addons.xpi {{CURL_OUT}} "$HOME/Downloads/zotero-addons.xpi"


