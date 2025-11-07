{
  lib,
  config,
  ...
}: {
  options.currentUser = {
    defaultShell = lib.mkOption {
      type = lib.types.enum ["zsh" "bash" "fish"];
      default = "zsh";
      description = "The default shell to use.";
    };

    defaultTerminal = lib.mkOption {
      type = lib.types.str;
      default = "ghostty";
      description = "The default terminal emulator.";
    };

    defaultTerminalRunner = lib.mkOption {
      type = lib.types.str;
      default = config.currentUser.defaultTerminal;
      description = "The default terminal emulator to run CLI softwares directly";
    };

    defaultExplorer = lib.mkOption {
      type = lib.types.str;
      default = "thunar";
      description = "The default file explorer";
    };

    defaultTerminalExplorer = lib.mkOption {
      type = lib.types.str;
      default = "yazi";
      description = "The default file explorer with TUI";
    };

    iconTheme = lib.mkOption {
      type = lib.types.str;
      default = "Breeze";
      description = "Default icon theme";
    };
  };
}
