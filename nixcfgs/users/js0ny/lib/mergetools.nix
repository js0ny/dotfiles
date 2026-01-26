{
  config,
  lib,
  pkgs,
  ...
}: let
  # Helper to handle the logic check string
  # 如果 force 为 true，Bash 变量 FORCE 为 "true"，否则为 "false"
  # In Nix, (toString true) yields "1"
  mkForceVar = force:
    if force
    then "true"
    else "false";

  mkMergedYaml = {
    name,
    target,
    settings,
    force ? false,
  }: let
    yamlContent = lib.generators.toYAML {} settings;
    patchFile = "${target}.nix-managed";
  in {
    home.file."${patchFile}".text = yamlContent;

    home.activation."merge-${name}" = lib.hm.dag.entryAfter ["writeBoundary"] ''
      TARGET="$HOME/${target}"
      PATCH="$HOME/${patchFile}"
      FORCE="${mkForceVar force}"

      if [ -f "$TARGET" ] || [ "$FORCE" = "true" ]; then
        if [ -f "$PATCH" ]; then
          verboseEcho "Merging Nix managed YAML config into: $TARGET"

          # 只有在确定要操作时，才创建目录和空文件
          run mkdir -p "$(dirname "$TARGET")"

          if [ ! -f "$TARGET" ]; then
            echo "{}" > "$TARGET"
          fi

          run ${pkgs.yq-go}/bin/yq -i -oy -P ". *= load(\"$PATCH\")" "$TARGET"
        fi
      else
        verboseEcho "Skipping merge for $TARGET: file missing and force=false"
      fi
    '';
  };

  mkMergedJson = {
    name,
    target,
    settings,
    force ? false,
  }: let
    jsonContent = builtins.toJSON settings;
    patchFile = "${target}.nix-managed";
  in {
    home.file."${patchFile}".text = jsonContent;

    home.activation."merge-${name}" = lib.hm.dag.entryAfter ["writeBoundary"] ''
      TARGET="$HOME/${target}"
      PATCH="$HOME/${patchFile}"
      FORCE="${mkForceVar force}"

      if [ -f "$TARGET" ] || [ "$FORCE" = "true" ]; then
        if [ -f "$PATCH" ]; then
          verboseEcho "Merging Nix managed JSON config into: $TARGET"

          run mkdir -p "$(dirname "$TARGET")"

          if [ ! -f "$TARGET" ]; then
            echo "{}" > "$TARGET"
          fi

          run ${pkgs.yq-go}/bin/yq -i -o json -P --indent 2 ". *= load(\"$PATCH\")" "$TARGET"
        fi
      else
        verboseEcho "Skipping merge for $TARGET: file missing and force=false"
      fi
    '';
  };

  mkMergedIni = {
    name,
    target,
    settings,
    force ? false,
  }: let
    iniContent = lib.generators.toINI {} settings;
    patchFile = "${target}.nix-managed";
  in {
    home.file."${patchFile}".text = iniContent;

    home.activation."merge-${name}" = lib.hm.dag.entryAfter ["writeBoundary"] ''
      TARGET="$HOME/${target}"
      PATCH="$HOME/${patchFile}"
      FORCE="${mkForceVar force}"

      if [ -f "$TARGET" ] || [ "$FORCE" = "true" ]; then
        if [ -f "$PATCH" ]; then
          verboseEcho "Merging Nix managed INI config into: $TARGET"

          run mkdir -p "$(dirname "$TARGET")"

          if [ ! -f "$TARGET" ]; then
            echo "" > "$TARGET"
          fi

          run ${pkgs.crudini}/bin/crudini --merge "$TARGET" < "$PATCH"
        fi
      else
         verboseEcho "Skipping merge for $TARGET: file missing and force=false"
      fi
    '';
  };
in {
  inherit mkMergedYaml mkMergedJson mkMergedIni;
}
