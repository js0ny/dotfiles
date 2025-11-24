{pkgs, ...}: {
  programs.zed-editor = {
    enable = true;
    package =
      if pkgs.stdenv.isLinux
      then pkgs.zed-editor-fhs
      else pkgs.zed-editor;
    extensions = [
      "catppuccin"
      "material-icon-theme"
      "git-firefly"
    ];
    userKeymaps = [
      {
        context = "Workspace";
        bindings = {};
      }
      {
        context = "Editor";
        bindings = {
          alt-k = "editor::AddSelectionAbove";
          alt-j = "editor::AddSelectionBelow";
        };
      }
      {
        context = "vim_mode == visual || vim_mode == operator";
        bindings = {
          H = "vim::StartOfLine";
          L = "vim::EndOfLine";
        };
      }
      {
        context = "vim_mode == normal";
        bindings = {
          H = "pane::ActivatePreviousItem";
          L = "pane::ActivateNextItem";
          Y = [
            "workspace::SendKeystrokes"
            "y $"
          ];
        };
      }
      {
        context = "Editor && vim_mode == normal && !VimWaiting && !menu";
        bindings = {
          "space space" = "file_finder::Toggle";
          "space ;" = "command_palette::Toggle";
          "space !" = "workspace::NewTerminal";
          "space /" = "pane::DeploySearch";
          "space f c" = "zed::OpenSettings";
          "space f e c" = "zed::OpenSettings";
          "space f t" = "project_panel::ToggleFocus";
          "space c f" = "editor::Format";
          "space b D" = "workspace::CloseInactiveTabsAndPanes";
          "ctrl-w alt-h" = "workspace::ToggleLeftDock";
          "ctrl-w alt-l" = "workspace::ToggleRightDock";
          "ctrl-w alt-j" = "workspace::ToggleBottomDock";
          "[ d" = "editor::GoToPreviousDiagnostic";
          "] d" = "editor::GoToDiagnostic";
          "[ g" = "editor::GoToPreviousHunk";
          "] g" = "editor::GoToHunk";
        };
      }
      {
        context = "vim_mode == normal || vim_mode == visual || vim_mode == operator";
        bindings = {
          j = "vim::Down";
          k = "vim::Up";
          l = "vim::Right";
          n = "search::SelectNextMatch";
          N = "search::SelectPreviousMatch";
          J = [
            "workspace::SendKeystrokes"
            "j j j j j"
          ];
          K = [
            "workspace::SendKeystrokes"
            "k k k k k"
          ];
        };
      }
      {
        context = "ProjectPanel && not_editing";
        bindings = {
          j = "menu::SelectNext";
          k = "menu::SelectPrevious";
          l = "project_panel::ExpandSelectedEntry";
          A = "project_panel::NewDirectory";
          a = "project_panel::NewFile";
          d = "project_panel::Delete";
        };
      }
      {
        context = "Terminal";
        bindings = {
          ctrl-p = [
            "terminal::SendKeystroke"
            "ctrl-p"
          ];
          ctrl-n = [
            "terminal::SendKeystroke"
            "ctrl-n"
          ];
          ctrl-T = "workspace::NewTerminal";
          ctrl-w = null;
          "ctrl-w ctrl-w" = [
            "terminal::SendKeystroke"
            "ctrl-w"
          ];
          "ctrl-w h" = "workspace::ActivatePaneLeft";
          "ctrl-w k" = "workspace::ActivatePaneUp";
          "ctrl-w l" = "workspace::ActivatePaneRight";
          "ctrl-w j" = "workspace::ActivatePaneDown";
        };
      }
      {
        context = "vim_mode == normal || vim_mode == visual";
        bindings = {
          s = "vim::PushSneak";
          shift-s = "vim::PushSneakBackward";
        };
      }
    ];

    userSettings = {
      icon_theme = "Material Icon Theme";
      theme = {
        mode = "system";
        light = "Catppuccin Latte";
        dark = "Catppuccin Mocha";
      };
      tabs = {
        show_diagnostics = "errors";
        show_close_button = "hover";
        file_icons = true;
      };
      base_keymap = "VSCode";
      vim_mode = true;
      vim = {
        use_system_clipboard = "on_yank";
        use_smartcase_find = true;
      };
      features = {
        edit_prediction_provider = "zed";
      };
      outline_panel = {
        dock = "right";
      };
      edit_predictions = {
        disabled_globs = [
          "*.bean"
          "*.env"
          "secrets.yaml"
        ];
        copilot = {
          proxy = null;
          proxy_no_verify = null;
        };
      };
      ui_font_size = 16;
      buffer_font_size = null;
      relative_line_numbers = true;
      buffer_font_family = "Maple Mono NF CN";
      remove_trailing_whitespace_on_save = true;
      agent = {
        default_model = {
          provider = "openrouter";
          model = "openai/gpt-5.1-codex";
        };
      };
      inlay_hints = {
        enabled = true;
        show_type_hints = true;
        show_parameter_hints = true;
      };
      terminal = {
        detect_venv = {
          on = {
            directories = [
              ".venv"
            ];
          };
        };
        dock = "bottom";
        env = {
          EDITOR = "zeditor --wait";
        };
        shell = {
          program = "zsh";
        };
        option_as_meta = true;
      };
      file_types = {
        JSON = [
          "*.code-snippets"
        ];
      };
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      languages = {
        YAML = {
          tab_size = 2;
        };
        Nix = {
          tab_size = 2;
          formatter = {
            external = {
              command = "alejandra";
              arguments = [
                "--quiet"
                "--"
              ];
            };
          };
          completions = {
            lsp_insert_mode = "replace";
          };
        };
        Lua = {
          tab_size = 2;
          formatter = {
            external = {
              command = "stylua";
            };
          };
        };
      };
    };
  };
}
