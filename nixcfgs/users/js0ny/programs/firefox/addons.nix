{pkgs, ...}: let
  addons = pkgs.firefox-addons;
in {
  # imports = [./lib.nix]; # TODO: Declarative extension permissions
  catppuccin.firefox.enable = true;
  programs.firefox.profiles.default = {
    extensions.force = true;
    extensions.packages = with addons; [
      # Keybindings & Gestures & User Scripts
      foxy-gestures
      shortkeys
      surfingkeys_ff
      violentmonkey

      # Theming
      material-icons-for-github
      firefox-color

      # Browsing Enhancement
      darkreader
      bionic-reader
      ublock-origin
      refined-github-
      global-speed
      buster-captcha-solver
      sidebery

      # Cookies
      cookie-quick-manager
      cookie-autodelete
      consent-o-matic # istilldontcareaboutcookies alt

      # Privacy
      google-container
      facebook-container
      dont-track-me-google1

      ### Site Specific
      # Steam
      steam-database
      protondb-for-steam
      # YouTube
      return-youtube-dislikes
      sponsorblock
      # Bilibili
      bilisponsorblock

      # Misc
      rsshub-radar
      proton-pass
      # proton-vpn
      styl-us
      kiss-translator

      # Disabled
      # view-page-archive # Web Archives
      # single-file
      # downthemall

      # Install globally by policies: see modules/nixos/programs/firefox.nix
      # clearurls
      # multi-account-container
    ];
    userChrome = ''
      /* Sidebery Friendly Minimalist Style */
      :root {
        --tab-min-height: 30px !important;
        --toolbarbutton-inner-padding: 6px !important;
      }
      #TabsToolbar {
        visibility: collapse !important;
      }

      #sidebar-header { display: none; }
      #sidebar-box {
          padding: 0 !important;
      }

      /* disable: <div class="buttons-wrapper"> */
      .buttons-wrapper {
          display: none !important;
      }

      #sidebar-button {
          display: none !important;
      }

      #sidebar-panel-header {
          display: none !important;
      }

    '';
  };

  programs.firefox = {
    policies = {
      ExtensionSettings = [
        {
          name = "zotero@chnm.gmu.edu";
          value = {
            install_url = "https://download.zotero.org/connector/firefox/release/Zotero_Connector-5.0.189.xpi";
            installation_mode = "allow";
            private_browsing = false;
          };
        }
      ];
    };
  };
}
