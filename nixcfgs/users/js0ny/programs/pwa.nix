{
  config,
  pkgs,
  lib,
  ...
}: let
  pwaBrowser =
    if config.programs.chromium.enable
    then config.programs.chromium.package
    else pkgs.chromium;
  pwaExe = lib.getExe pwaBrowser;
  pwaBuilder = name: url: icon: genericName: {
    name = name;
    genericName = genericName;
    exec = "${pwaExe} --app=${url}";
    terminal = false;
    icon = icon;

    settings = {
      StartupWMClass = "pwa-${name}";
    };
  };
  pwaBuilderDefault = name: url: pwaBuilder name url "web-app-icon" "Web Application";
in {
  xdg.desktopEntries = {
    claude = pwaBuilderDefault "Claude" "https://claude.ai";
    grok = pwaBuilderDefault "Grok" "https://grok.com";
    chatgpt = pwaBuilderDefault "ChatGPT" "https://chatgpt.com";
    gemini = pwaBuilderDefault "Gemini" "https://gemini.google.com";
    notebooklm = pwaBuilderDefault "NotebookLM" "https://notebooklm.google.com";
    qwenai = pwaBuilderDefault "QwenAI" "https://chat.qwen.ai";
    folo = pwaBuilderDefault "Folo" "https://app.folo.is";
    tradingview = pwaBuilderDefault "TradingView" "https://www.tradingview.com";
  };
}
