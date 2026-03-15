{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    systemd.enable =
      if pkgs.stdenv.isDarwin
      then false
      else true;
    # Not ready
    settings = {
      command = "${lib.getExe config.my.desktop.preferredApps.interactiveShell}";
      font-size = 13;
      font-family = "Maple Mono NF CN";
      # theme = light:Catppuccin Latte,dark:Catppuccin Mocha;
      # background-opacity = 0.8;

      cursor-style = "block_hollow";
      cursor-style-blink = true;
      cursor-click-to-move = true;
      cursor-invert-fg-bg = true;

      window-decoration = "auto";
      macos-option-as-alt = "left";

      # title = "👻";

      ### Keybindings

      keybind = [
        "performable:ctrl+c=copy_to_clipboard"
        "alt+shift+h=goto_split:left"
        "alt+shift+j=goto_split:bottom"
        "alt+shift+k=goto_split:top"
        "alt+shift+l=goto_split:right"
        "alt+shift+|=new_split:right"
        "alt+shift+_=new_split:down"
        "alt+shift+enter=new_split:auto"
        "global:super+backquote=toggle_quick_terminal"
      ];

      ### Misc

      app-notifications = "no-clipboard-copy";

      ### Reference to:
      # https://github.com/folke/dot/blob/master/config/ghostty/config
      # https://github.com/hackr-sh/ghostty-shaders
    };
  };
}
