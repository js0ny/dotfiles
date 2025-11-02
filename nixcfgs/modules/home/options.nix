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

    iconTheme = lib.mkOption {
      type = lib.types.str;
      default = "Breeze";
      description = "Default icon theme";
    };
  };
}
