{
  lib,
  pkgs,
  ...
}: let
  profileDir =
    if pkgs.stdenv.isDarwin
    then "Library/Application Support/Firefox/Profiles"
    else ".mozilla/firefox";
in {
  # Overwrite search.json.mozlz4
  home.file."${profileDir}/default/search.json.mozlz4".force = lib.mkForce true;
  programs.firefox.profiles.default.search.engines = {
    alternativeto = {
      name = "AlternativeTo";
      urls = [{template = "https://alternativeto.net/browse/search/?q={searchTerms}";}];
      icon = "https://alternativeto.net/favicon.ico";
      definedAliases = ["a2"];
    };
    archwiki = {
      name = "ArchWiki";
      urls = [{template = "https://wiki.archlinux.org/index.php?search={searchTerms}";}];
      icon = "https://archlinux.org/favicon.ico";
      definedAliases = ["aw"];
    };
    aur = {
      name = "Arch User Repository";
      urls = [{template = "https://aur.archlinux.org/packages?K={searchTerms}";}];
      icon = "https://archlinux.org/favicon.ico";
      definedAliases = ["aur" "yay" "paru"];
    };
    arch-packages = {
      name = "ArchLinux Packages";
      urls = [{template = "https://archlinux.org/packages/?q={searchTerms}";}];
      icon = "https://archlinux.org/favicon.ico";
      definedAliases = ["pac" "pacman"];
    };
    chatgpt = {
      name = "ChatGPT";
      urls = [{template = "https://chatgpt.com/?q={searchTerms}";}];
      icon = "https://chatgpt.com/favicon.ico";
      definedAliases = ["gpt" "chatgpt"];
    };
    scoop = {
      name = "scoop";
      urls = [{template = "https://scoop.sh/#/apps?q={searchTerms}";}];
      icon = "https://scoop.sh/favicon.ico";
      definedAliases = ["sc" "scoop"];
    };
    perplexity = {
      name = "Perplexity";
      urls = [{template = "https://www.perplexity.ai/?q={searchTerms}";}];
      icon = "https://perplexity.ai/favicon.ico";
      definedAliases = ["pplx"];
    };
    pypi = {
      name = "PyPi";
      urls = [{template = "https://pypi.org/search/?q={searchTerms}";}];
      icon = "https://pypi.org/favicon.ico";
      definedAliases = ["py" "pypi"];
    };
    winget = {
      name = "Windows Package Manager";
      urls = [{template = "https://winget.ragerworks.com/search/all/{searchTerms}";}];
      icon = "https://microsoft.com/favicon.ico";
      definedAliases = ["win" "winget"];
    };
    github = {
      name = "GitHub Repository";
      urls = [{template = "https://github.com/search?type=repositories&q={searchTerms}";}];
      icon = "https://github.com/favicon.ico";
      definedAliases = ["gh" "ghr" "github"];
    };
    repology = {
      name = "Repology";
      urls = [{template = "https://repology.org/projects/?search={searchTerms}";}];
      icon = "https://repology.org/favicon.ico";
      definedAliases = ["repo" "repology"];
    };
    claude = {
      name = "Claude";
      urls = [{template = "https://claude.ai/?q={searchTerms}";}];
      icon = "https://claude.ai/favicon.ico";
      definedAliases = ["cl" "claude"];
    };
    grok = {
      name = "Grok";
      urls = [{template = "https://grok.com/?q={searchTerms}";}];
      icon = "https://grok.com/favicon.ico";
      definedAliases = ["grok"];
    };
    fedora-package = {
      name = "Fedora Packages";
      urls = [{template = "https://packages.fedoraproject.org/search?query={searchTerms}";}];
      icon = "https://fedoraproject.org/favicon.ico";
      definedAliases = ["dnf"];
    };
    youtube = {
      name = "Youtube";
      urls = [{template = "https://www.youtube.com/results?search_query={searchTerms}";}];
      icon = "https://youtube.com/favicon.ico";
      definedAliases = ["yt" "youtube"];
    };
    nixpkgs = {
      name = "Nix Packages";
      urls = [{template = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";}];
      icon = "https://nixos.org/favicon.ico";
      definedAliases = ["np" "nixpkg"];
    };
    nixopts = {
      name = "Nix Options";
      urls = [{template = "https://search.nixos.org/options?channel=unstable&query={searchTerms}";}];
      icon = "https://nixos.org/favicon.ico";
      definedAliases = ["no" "nixopt"];
    };
    home-manager = {
      name = "Home Manager Options";
      urls = [{template = "https://home-manager-options.extranix.com/?query={searchTerms}";}];
      icon = "https://nixos.org/favicon.ico";
      definedAliases = ["hm"];
    };
    flathub = {
      name = "Flathub";
      urls = [{template = "https://flathub.org/apps/search?q={searchTerms}";}];
      icon = "https://flathub.org/favicon.ico";
      definedAliases = ["flatpak" "flathub"];
    };
  };
}
