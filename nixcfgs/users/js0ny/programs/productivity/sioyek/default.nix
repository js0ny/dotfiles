{
  pkgs,
  config,
  lib,
  ...
}: let
  sioyekCopyScript = pkgs.writeShellApplication {
    name = "sioyek-copy-page";
    runtimeInputs = with pkgs;
      [poppler-utils]
      ++ (
        if pkgs.stdenv.isLinux
        then with pkgs; [wl-clipboard libnotify]
        else []
      );
    text = builtins.readFile ./sioyek-copy-page.sh;
  };
in {
  xdg.configFile."sioyek/prefs_user.config".text = ''
    new_command _copy_page_to_clipboard ${lib.getExe sioyekCopyScript} %{page_number} %{file_path}
    default_dark_mode 1
    font_size 14
    case_sensitive_search 0
    super_fast_search 1
    search_url_d https://duckduckgo.com/?q=
    search_url_e https://ai.js0ny.net/?models=qwen%2Fqwen3-235b-a22b-2507&q=explain-
  '';
  programs.sioyek = {
    enable = true;
    # prefs_user.config
    bindings = {
      ## Movement
      "screen_down" = "J";
      "screen_up" = "K";

      "move_up_smooth" = "k";
      "move_down_smooth" = "j";
      "move_left_smooth" = "h";
      "move_right_smooth" = "l";
      ## Zoom

      "zoom_in" = "=";

      ## Highlight
      "add_highlight" = "H";

      ### Toggles
      "toggle_dark_mode" = ["i" ",D"];
      "toggle_fullscreen" = ",f";
      "toggle_custom_color" = ",d";
      # toggle_dark_mode     D
      ## SyncTeX for LaTeX
      "toggle_synctex" = ",s";

      # Mark
      "goto_mark" = "'";

      ### Misc
      "quit" = "Q";

      "copy" = "y";

      "goto_toc" = "<tab>";

      ## Smart Jump, Portals

      "overview_link" = "<C-p>";

      ## Muscle Memory Bindings

      "command" = "<A-x>";
      "search" = "<C-f>";

      ## User Defined Commands
      "_copy_page_to_clipboard" = "<A-c>";
    };
  };
}
