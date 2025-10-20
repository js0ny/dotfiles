{pkgs, ...}: {
  programs.floorp = {
    enable = true;
    package = pkgs.floorp;
    policies = {
      DisableTelemetry = true;
      BlockAboutConfig = false;
      DisableFirefoxScreenshots = true;
      DontCheckDefaultBrowser = true;

      ExtensionSettings = with builtins; let
        extension = short: uuid: {
          name = uuid;
          value = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
            installation_mode = "force_installed";
          };
        };
      in
        listToAttrs [
          (extension "ublock-origin" "uBlock0@raymondhill.net")
          (extension "multi-account-containers" "@testpilot-containers")
          (extension "side-view" "@webcompat@mozilla.org")
          (extension "clearurls" "{74145f27-f039-47ce-a470-a662b129930a}")
        ];

      SearchEngines = {
        Default = "DuckDuckGo";
        Add = [
          {
            Alias = "@np";
            Description = "Search in NixOS Packages";
            IconURL = "https://nixos.org/favicon.ico";
            Method = "GET";
            Name = "NixOS Packages";
            URLTemplate = "https://search.nixos.org/packages?from=0&size=200&sort=relevance&type=packages&query={searchTerms}";
          }
          {
            Alias = "@no";
            Description = "Search in NixOS Options";
            IconURL = "https://nixos.org/favicon.ico";
            Method = "GET";
            Name = "NixOS Options";
            URLTemplate = "https://search.nixos.org/options?from=0&size=200&sort=relevance&type=packages&query={searchTerms}";
          }
          {
            Alias = "@hm";
            Description = "Search in Home Manager Options";
            IconURL = "https://nixos.org/favicon.ico";
            Method = "GET";
            Name = "Home Manager options";
            URLTemplate = "https://home-manager-options.extranix.com/?query={searchTerms}";
          }
        ];
      };
    };
    profiles.default = {
      search.engines = {
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
          urls = [{template = "https://archlinux.org/?q={searchTerms}";}];
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
      };
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        darkreader
        rsshub-radar
        proton-pass
        surfingkeys
        web-archives
        #       immersive-translate
        tampermonkey
        stylus
        foxy-gestures
        google-container
        refined-github
        downthemall
        material-icons-for-github
        single-file
        return-youtube-dislikes
        steam-database
        bilisponsorblock
        sponsorblock
        buster-captcha-solver
      ];
    };
  };
}
