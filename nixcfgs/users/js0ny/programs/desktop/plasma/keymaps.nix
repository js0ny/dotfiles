{...}: {
  programs.plasma.hotkeys.commands = {
    "launch-obsidian" = {
      name = "Launch Obsidian";
      key = "Meta+O";
      command = "obsidian";
    };
    "launch-terminal" = {
      name = "Launch Terminal";
      key = "Meta+Return";
      command = "kitty";
    };
  };
}
