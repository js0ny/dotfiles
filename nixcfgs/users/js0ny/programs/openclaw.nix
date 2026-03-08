# OpenClaw - AI Gateway with Telegram/Discord Integration
# Documentation: https://github.com/openclaw/nix-openclaw
{
  pkgs,
  lib,
  config,
  ...
}: let
  # Import local machine-specific values (git-ignored)
  # Create nixcfgs/secrets/local.nix with your Telegram User ID
  localSecrets = import ../../../secrets/local.nix;
in {
  programs.openclaw = {
    enable = true;

    # Documents directory containing AGENTS.md, SOUL.md, TOOLS.md, etc.
    # Located at ~/.local/share/openclaw-docs
    documents = "${config.home.homeDirectory}/.local/share/openclaw-docs";

    # Core gateway configuration
    config = {
      gateway = {
        mode = "local"; # "local" or "remote"
        auth = {
          # Gateway authentication token (managed by sops-nix)
          token = config.sops.secrets."OPENCLAW_GATEWAY_TOKEN".path;
        };
      };

      # Communication channels
      channels = {
        telegram = {
          # Get bot token from @BotFather on Telegram (managed by sops-nix)
          tokenFile = config.sops.secrets."OPENCLAW_TGBOT_TOKEN".path;

          # Your Telegram user ID - get from @userinfobot
          # Imported from nixcfgs/secrets/local.nix (git-ignored)
          allowFrom = lib.optionals (localSecrets.telegramUserId != 0) [
            localSecrets.telegramUserId
          ];

          # Group chat configuration
          groups = {
            "*" = {requireMention = true;}; # Default: require @mention in all groups
            # "-1001234567890" = { requireMention = false; }; # Specific group without @mention
          };
        };

        # Discord configuration (optional)
        # discord = {
        #   tokenFile = config.sops.secrets."DISCORD_BOT_TOKEN".path;
        #   allowFrom = [
        #     "your-discord-user-id"
        #   ];
        # };
      };

      # Provider API keys (managed by sops-nix)
      env.vars = {
        OPENROUTER_API_KEY = config.sops.secrets."OPENROUTER_API_KEY".path;
        # OPENAI_API_KEY = config.sops.secrets."OPENAI_API_KEY".path;
      };
    };

    # Built-in plugins
    bundledPlugins = {
      summarize.enable = true; # Summarize web pages, PDFs, videos
      peekaboo.enable = lib.mkIf pkgs.stdenv.isDarwin true; # Take screenshots (macOS only)
      poltergeist.enable = false; # Control macOS UI (macOS only)
      sag.enable = false; # Text-to-speech
      camsnap.enable = false; # Camera snapshots (macOS only)
      gogcli.enable = false; # Google Calendar integration
      goplaces.enable = false; # Google Places API
      bird.enable = false; # Twitter/X integration
      sonoscli.enable = false; # Sonos speaker control
      imsg.enable = false; # iMessage integration (macOS only)

      # Example: Plugin with sops-nix configuration
      # goplaces = {
      #   enable = true;
      #   config.env.GOOGLE_PLACES_API_KEY = config.sops.secrets."GOOGLE_PLACES_API_KEY".path;
      # };
    };

    # Custom/community plugins
    # plugins = [
    #   # Simple plugin from GitHub
    #   { source = "github:owner/repo-name"; }
    #
    #   # Plugin with sops-nix managed secrets
    #   {
    #     source = "github:owner/plugin-name";
    #     config = {
    #       env = {
    #         PLUGIN_AUTH_FILE = config.sops.secrets."PLUGIN_AUTH_KEY".path;
    #       };
    #       settings = {
    #         default_option = "value";
    #         retries = 3;
    #         tags = [ "tag1" "tag2" ];
    #       };
    #     };
    #   }
    #
    #   # Local plugin development
    #   { source = "path:${config.home.homeDirectory}/code/my-openclaw-plugin"; }
    # ];

    # Tool management (avoid conflicts with system packages)
    # excludeTools = [ "git" "jq" "ripgrep" ];  # Exclude tools already installed
  };

  # Multi-instance configuration (advanced)
  # Use when you need separate prod/dev environments
  # programs.openclaw.instances = {
  #   prod = {
  #     enable = true;
  #     stateDir = "${config.home.homeDirectory}/.openclaw";
  #     workspaceDir = "${config.home.homeDirectory}/.openclaw/workspace";
  #     config = {
  #       gateway.auth.token = config.sops.secrets."OPENCLAW_GATEWAY_TOKEN_PROD".path;
  #       channels.telegram.tokenFile = config.sops.secrets."TELEGRAM_BOT_TOKEN_PROD".path;
  #       # ... other prod config
  #     };
  #     plugins = [ /* production plugins */ ];
  #   };
  #
  #   dev = {
  #     enable = true;
  #     gatewayPort = 18790;
  #     gatewayPath = "${config.home.homeDirectory}/code/openclaw";  # Local development
  #     config = {
  #       gateway.auth.token = config.sops.secrets."OPENCLAW_GATEWAY_TOKEN_DEV".path;
  #       channels.telegram.tokenFile = config.sops.secrets."TELEGRAM_BOT_TOKEN_DEV".path;
  #       # ... other dev config
  #     };
  #     plugins = [ /* dev plugins with local overrides */ ];
  #   };
  # };
}
