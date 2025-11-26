{...}: {
  programs.walker = {
    enable = true;
    runAsService = true;
    providers.prefixes = [
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
}
