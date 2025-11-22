{
  config,
  pkgs,
  ...
}: let
  alt =
    if pkgs.stdenv.isDarwin
    then "cmd"
    else "alt";
in {
  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };
    environment = {
      "TERM_PROGRAM" = "kitty";
    };
    font = {
      size = 12;
      name = "Maple Mono NF CN";
    };
    settings = {
      # Font
      disable_ligatures = "never";
      # Cursor Trail
      cursor_trail = 1;
      cursor_trail_decay = "0.1 0.4";
      cursor_trail_start_threshold = 2;
      # Tab Bar
      tab_bar_edge = "top";
      tab_bar_align = "left";
      tab_bar_style = "powerline";
      # Hide tab bar when there is only one tab
      tab_bar_min_tabs = 2;
      tab_title_template = "{f'{title[:30]}…' if title.rindex(title[-1]) + 1 > 30 else (title.center(6) if (title.rindex(title[-1]) + 1) % 2 == 0 else title.center(5))}";
      active_tab_font_style = "bold";
      # macOS # TODO: true or "yes", untested
      macos_option_as_alt = true;
      macos_quit_when_last_window_closed = true;
      enabled_layouts = "splits";
      shell = config.currentUser.defaultShell;
      allow_remote_control = "socket-only";
      listen_on = "unix:/tmp/kitty.sock";
    };
    keybindings = {
      "cmd+c" = "copy_and_clear_or_interrupt";
      "ctrl+c" = "copy_and_clear_or_interrupt";
      "${alt}+1" = "goto_tab 1";
      "${alt}+2" = "goto_tab 2";
      "${alt}+3" = "goto_tab 3";
      "${alt}+4" = "goto_tab 4";
      "${alt}+5" = "goto_tab 5";
      "${alt}+6" = "goto_tab 6";
      "${alt}+7" = "goto_tab 7";
      "${alt}+8" = "goto_tab 8";
      "${alt}+9" = "goto_tab 9"; # if less than 9 tabs, goes to last tab
      "${alt}+0" = "goto_tab -1"; # previously active tab
      "${alt}+shift+\\" = "launch --location=vsplit";
      "${alt}+shift+-" = "launch --location=hsplit";
      "ctrl+shift+h" = "kitty_scrollback_nvim";
      "ctrl+shift+g" = "kitty_scrollback_nvim --config ksb_builtin_last_cmd_output";
      "alt+shift+h" = "focus left";
      "alt+shift+l" = "focus right";
      "alt+shift+k" = "focus up";
      "alt+shift+j" = "focus down";
      "ctrl+q>h" = "focus left";
      "ctrl+q>l" = "focus right";
      "ctrl+q>k" = "focus up";
      "ctrl+q>j" = "focus down";
    };
    extraConfig = ''
      mouse_map ctrl+shift+right press ungrabbed combine : mouse_select_command_output : kitty_scrollback_nvim --config ksb_builtin_last_visited_cmd_output
    '';
    actionAliases =
      if config.programs.neovim.enable
      then {
        "kitty_scrollback_nvim" = "kitten /home/js0ny/.local/share/nvim/lazy/kitty-scrollback.nvim/python/kitty_scrollback_nvim.py";
      }
      else {};
  };
}
