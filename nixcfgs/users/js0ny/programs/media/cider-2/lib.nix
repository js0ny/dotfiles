{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.cider-2;
  ciderConfigDir = "sh.cider.genten";

  # --- 1. 辅助函数：Cider Marketplace Fetcher ---
  fetchCiderMarketplace = {
    projectId,
    version,
    sha256,
  }:
    pkgs.runCommand "cider-extension-${toString projectId}" {
      nativeBuildInputs = [pkgs.unzip];
      src = pkgs.fetchurl {
        url = "https://api.connect.cider.sh/marketplace/projects/${toString projectId}/versions/${version}/download";
        inherit sha256;
      };
    } ''
      mkdir -p $out
      unzip $src -d $out
    '';

  # --- 2. 类型定义：Entry Submodule ---
  # 这个 submodule 定义了单一 Theme 或 Plugin 的配置结构
  entryType = types.submodule ({
    name,
    config,
    ...
  }: {
    options = {
      src = mkOption {
        type = types.nullOr types.path;
        default = null;
        description = "Direct path or derivation to the theme/plugin directory.";
      };

      marketplace = mkOption {
        default = null;
        description = "Download from Cider Marketplace.";
        type = types.nullOr (types.submodule {
          options = {
            id = mkOption {
              type = types.int;
              description = "Project ID (e.g. 10)";
            };
            version = mkOption {
              type = types.str;
              description = "Version string (e.g. 1.1.0)";
            };
            sha256 = mkOption {
              type = types.str;
              description = "SRI Hash or SHA256";
            };
          };
        });
      };
    };
  });

  # --- 3. 逻辑转换函数 ---
  # 将用户的 submodule 配置转换为最终的 store path
  resolveEntry = name: entryCfg:
    if entryCfg.src != null
    then entryCfg.src
    else if entryCfg.marketplace != null
    then
      fetchCiderMarketplace {
        projectId = entryCfg.marketplace.id;
        inherit (entryCfg.marketplace) version sha256;
      }
    else throw "programs.cider-2: Theme/Plugin '${name}' must have either 'src' or 'marketplace' defined.";
in {
  # --- Options 定义 ---
  options.programs.cider-2 = {
    enable = mkEnableOption "Cider 2";

    package = mkOption {
      type = types.package;
      default = pkgs.cider-2;
      defaultText = literalExpression "pkgs.cider-2";
    };

    themes = mkOption {
      # Key 是目录名 (对于 Marketplace theme 通常是 ID，如 "12")
      type = types.attrsOf entryType;
      default = {};
      description = "Themes configuration.";
    };

    plugins = mkOption {
      # Key 是 literalId (如 "ch.kaifa.listenbrainz")
      type = types.attrsOf entryType;
      default = {};
      description = "Plugins configuration.";
    };
  };

  # --- Config 实现 ---
  config = mkIf cfg.enable {
    home.packages = [cfg.package];

    xdg.configFile = let
      # 生成 Theme 路径: .../themes/<Key>
      mkTheme = name: entry:
        nameValuePair
        "${ciderConfigDir}/themes/${name}"
        {source = resolveEntry name entry;};

      # 生成 Plugin 路径: .../plugins/<Key (LiteralID)>
      mkPlugin = name: entry:
        nameValuePair
        "${ciderConfigDir}/plugins/${name}"
        {source = resolveEntry name entry;};
    in
      (mapAttrs' mkTheme cfg.themes) // (mapAttrs' mkPlugin cfg.plugins);
  };
}
