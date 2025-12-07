{...}: {
  programs.walker = {
    enable = true;
    runAsService = true;
    config = {
      keybinds = {
        next = ["Down" "ctrl j" "ctrl n"];
        previous = ["Up" "ctrl k" "ctrl p"];
      };
      providers = {
        default = [
          "websearch"
          "desktopapplications"
          "calc"
        ];
        prefixes = [
          {
            provider = "websearch";
            prefix = "+";
          }
          {
            provider = "providerlist";
            prefix = "_";
          }
        ];
      };
    };
  };
}
