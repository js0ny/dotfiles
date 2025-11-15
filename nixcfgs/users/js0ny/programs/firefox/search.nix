{lib, ...}: {
  # Overwrite search.json.mozlz4
  home.file.".mozilla/firefox/default/search.json.mozlz4".force = lib.mkForce true;
  programs.firefox.profiles.default.search.engines = {
    alternativeto = {
      name = "AlternativeTo";
      urls = [
        {template = "https://alternativeto.net/browse/search/?q={searchTerms}";}
      ];
      icon = "https://alternativeto.net/favicon.ico";
      definedAliases = ["@a2"];
    };
    archwiki = {
      name = "ArchWiki";
      urls = [
        {
          template = "https://wiki.archlinux.org/index.php?search={searchTerms}";
        }
      ];
      icon = "https://archlinux.org/favicon.ico";
      definedAliases = ["@aw"];
    };
    aur = {
      name = "Arch User Repository";
      urls = [
        {
          template = "https://aur.archlinux.org/?K={searchTerms}";
        }
      ];
      icon = "https://archlinux.org/favicon.ico";
      definedAliases = ["@aur"];
    };
    arch-packages = {
      name = "ArchLinux Packages";
      urls = [{template = "https://archlinux.org/packages/?q={searchTerms}";}];
      icon = "https://archlinux.org/favicon.ico";
      definedAliases = ["@pac"];
    };
    chatgpt = {
      name = "ChatGPT";
      urls = [{template = "https://chatgpt.com/?q={searchTerms}";}];
      icon = "https://chatgpt.com/favicon.ico";
      definedAliases = ["@gpt"];
    };
    scoop = {
      name = "scoop";
      urls = [{template = "https://scoop.sh/#/apps?q={searchTerms}";}];
      icon = "https://scoop.sh/favicon.ico";
      definedAliases = ["@sc"];
    };
    perplexity = {
      name = "Perplexity";
      urls = [{template = "https://www.perplexity.ai/?q={searchTerms}";}];
      icon = "https://perplexity.ai/favicon.ico";
      definedAliases = ["@pplx"];
    };
    pypi = {
      name = "PyPi";
      urls = [{template = "https://pypi.org/search/?q={searchTerms}";}];
      icon = "https://pypi.org/favicon.ico";
      definedAliases = ["@py"];
    };
    winget = {
      name = "Windows Package Manager";
      urls = [{template = "https://winget.ragerworks.com/search/all/{searchTerms}";}];
      icon = "https://microsoft.com/favicon.ico";
      definedAliases = ["@win"];
    };
    github = {
      name = "GitHub Repository";
      urls = [{template = "https://github.com/search?type=repositories&q={searchTerms}";}];
      icon = "https://github.com/favicon.ico";
      definedAliases = ["@gh"];
    };
    repology = {
      name = "Repology";
      urls = [{template = "https://repology.org/projects/?search={searchTerms}";}];
      icon = "https://repology.org/favicon.ico";
      definedAliases = ["@repo"];
    };
  };
}
