uv:
    uv init {{XDG_DATA_HOME}}/uvenv
    cd {{XDG_DATA_HOME}}/uvenv
    uv venv
    uv add -r {{DOTFILES}}/bootstrap/components/requirements.txt

vivaldi:
    {{CURL}} https://github.com/SocietasEvanescentes/Vivaldi/files/12446831/Rose.Pine.Dawn.zip {{CURL_OUT}} "$HOME/Downloads/vivaldi-light.zip" # Rose Pine Dawn
    {{CURL}} https://github.com/catppuccin/vivaldi/releases/download/1.0.0-ctpv2/Catppuccin.Mocha.Lavender.zip {{CURL_OUT}} "$HOME/Downloads/vivaldi-dark.zip" # Catppuccino Mocha Lavender


zotero:
    {{CURL}} https://github.com/syt2/zotero-addons/releases/download/V1.8.1/zotero-addons.xpi {{CURL_OUT}} "$HOME/Downloads/zotero-addons.xpi"


