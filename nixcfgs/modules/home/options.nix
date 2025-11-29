{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkOption types mkIf;
  cfg = config.my; # 简写引用，方便后续使用
in {
  options.my = {
    # === 软件生态配置 (Software Ecosystem) ===
    desktop = {
      preferredApps = {
        shell = mkOption {
          type = types.package;
          default = pkgs.bash;
          description = "The default shell package to use.";
          example = pkgs.zsh;
        };

        interactiveShell = mkOption {
          type = types.package;
          default = pkgs.bash;
          description = "The default interactive shell package. (spawn by terminal emulators)";
          example = pkgs.fish;
        };

        terminal = {
          package = mkOption {
            type = types.package;
            default = pkgs.alacritty;
            description = "The default terminal emulator package.";
            example = pkgs.kitty;
          };

          execArg = mkOption {
            type = types.str;
            default = "-e";
            description = "The argument used to execute a command in the terminal.";
          };
        };

        fileManager = {
          gui = mkOption {
            type = types.package;
            default = pkgs.thunar;
            description = "The default GUI file explorer.";
            example = pkgs.kdePackages.dolphin;
          };

          tui = mkOption {
            type = types.package;
            default = pkgs.yazi;
            description = "The default TUI file explorer.";
            example = pkgs.ranger;
          };
        };
      };

      style = {
        iconTheme = {
          # 分离包和名称：有些包名和主题名不一致
          package = mkOption {
            type = types.package;
            default = pkgs.kdePackages.breeze-icons;
            description = "The package containing the icon theme.";
            example = pkgs.papirus-icon-theme;
          };
          light = mkOption {
            type = types.str;
            default = "Breeze";
            description = "The internal name of the icon theme (as used in GTK/QT settings).";
            example = "Papirus-Light";
          };
          dark = mkOption {
            type = types.str;
            default = "Breeze-Dark";
            description = "The internal name of the dark icon theme (as used in GTK/QT settings).";
            example = "Papirus-Dark";
          };
        };
      };
    };

    # === 硬件/主机特性配置 (Hardware/Host Specifics) ===
    hardware = {
      # 使用 nullOr 允许该功能被完全禁用（如果在没有背光的台式机上）
      keyboardBacklight = mkOption {
        type = types.nullOr (types.submodule {
          options = {
            device = mkOption {
              type = types.str;
              description = "Device identifier for brightnessctl.";
            };
            step = mkOption {
              type = types.str;
              default = "5%"; # 稍微调小默认步进，更精细
              description = "Step percentage/integer for brightness adjustment.";
            };
          };
        });
        default = null;
        description = "Keyboard backlight configuration. Set to null to disable.";
      };

      isHeadless = mkOption {
        type = types.bool;
        default = false;
        description = "Whether the current host acts as a headless server.";
      };
    };
  };
}
