{...}: {
  programs.walker = {
    enable = true;
    runAsService = true;
    config = {
      keybinds = {
        next = ["Down" "ctrl j"];
        previous = ["Up" "ctrl k"];
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
