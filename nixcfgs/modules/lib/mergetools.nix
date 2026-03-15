# mergetools.nix — Dual-mode config merge library
#
# Supports both Home Manager ("home") and NixOS system-level ("system") modes.
# All targets are ABSOLUTE paths regardless of mode.
#
# Usage (home mode — default):
#   mergetools = import ../../modules/lib/mergetools.nix { inherit pkgs lib config; };
#   myConfig = mergetools.mkMergedJson {
#     name = "my-config";
#     target = "${config.home.homeDirectory}/.config/app/config.json";
#     settings = { key = "value"; };
#   };
#   # Then:  imports = [ myConfig ];
#
# Usage (system mode):
#   mergetools = import ../../modules/lib/mergetools.nix { inherit pkgs lib config; };
#   myConfig = mergetools.mkMergedJson {
#     name = "my-config";
#     target = "/var/lib/myapp/config.json";
#     settings = { key = "value"; };
#     mode = "system";
#     # owner = "myapp";      # default: "root"
#     # group = "myapp";      # default: "root"
#     # permissions = "0640";  # default: "0644"
#   };
#   # Then:  imports = [ myConfig ];
{
  config,
  lib,
  pkgs,
  ...
}: let
  mkForceVar = force:
    if force
    then "true"
    else "false";

  # Derive a safe relative path for home.file from an absolute target.
  # Strips the leading $HOME/ to get the relative portion.
  # e.g., "/home/js0ny/.config/foo" -> ".config/foo"
  stripHomePrefix = target: let
    homeDir = config.home.homeDirectory;
    homeDirSlash = homeDir + "/";
    len = builtins.stringLength homeDirSlash;
  in
    if lib.hasPrefix homeDirSlash target
    then builtins.substring len (builtins.stringLength target - len) target
    else builtins.abort "mergetools (home mode): target '${target}' must start with '${homeDirSlash}'";

  # ── Home mode ──────────────────────────────────────────────────────

  mkHomeMerge = {
    name,
    target,
    patchContent,
    mergeCmdStr,
    force,
    emptyInit,
  }: let
    relTarget = stripHomePrefix target;
    patchFile = "${relTarget}.nix-managed";
  in {
    home.file."${patchFile}".text = patchContent;

    home.activation."merge-${name}" = lib.hm.dag.entryAfter ["writeBoundary"] ''
      TARGET="${target}"
      PATCH="$HOME/${patchFile}"
      FORCE="${mkForceVar force}"

      if [ -f "$TARGET" ] || [ "$FORCE" = "true" ]; then
        if [ -f "$PATCH" ]; then
          verboseEcho "Merging Nix managed config into: $TARGET"
          run mkdir -p "$(dirname "$TARGET")"
          if [ ! -f "$TARGET" ]; then
            echo '${emptyInit}' > "$TARGET"
          fi
          run ${mergeCmdStr}
        fi
      else
        verboseEcho "Skipping merge for $TARGET: file missing and force=false"
      fi
    '';
  };

  # ── System mode ────────────────────────────────────────────────────

  mkSystemMerge = {
    name,
    target,
    patchContent,
    mergeCmdStr,
    force,
    emptyInit,
    owner ? "root",
    group ? "root",
    permissions ? "0644",
  }: let
    patchFile = pkgs.writeText "${name}.nix-managed" patchContent;
  in {
    system.activationScripts."merge-${name}" = lib.stringAfter ["etc"] ''
      TARGET="${target}"
      PATCH="${patchFile}"
      FORCE="${mkForceVar force}"

      if [ -f "$TARGET" ] || [ "$FORCE" = "true" ]; then
        echo "mergetools: Merging Nix managed config into: $TARGET"
        mkdir -p "$(dirname "$TARGET")"
        if [ ! -f "$TARGET" ]; then
          echo '${emptyInit}' > "$TARGET"
        fi
        ${mergeCmdStr}
        chown ${owner}:${group} "$TARGET"
        chmod ${permissions} "$TARGET"
      else
        echo "mergetools: Skipping merge for $TARGET: file missing and force=false"
      fi
    '';
  };

  # ── Dispatch ───────────────────────────────────────────────────────

  mkMerge = {mode ? "home", ...} @ args: let
    # Strip mode-irrelevant attrs before passing
    homeArgs = builtins.removeAttrs args ["mode" "owner" "group" "permissions"];
    systemArgs = builtins.removeAttrs args ["mode"];
  in
    if mode == "home"
    then mkHomeMerge homeArgs
    else if mode == "system"
    then mkSystemMerge systemArgs
    else builtins.abort "mergetools: unknown mode '${mode}', expected 'home' or 'system'";

  # ── Public API ─────────────────────────────────────────────────────

  mkMergedYaml = {
    name,
    target,
    settings,
    force ? false,
    mode ? "home",
    owner ? "root",
    group ? "root",
    permissions ? "0644",
  }:
    mkMerge {
      inherit name target mode force owner group permissions;
      patchContent = lib.generators.toYAML {} settings;
      # $TARGET and $PATCH are shell variables set in the activation script
      mergeCmdStr = ''${pkgs.yq-go}/bin/yq -i -oy -P ". *= load(\"$PATCH\")" "$TARGET"'';
      emptyInit = "{}";
    };

  mkMergedJson = {
    name,
    target,
    settings,
    force ? false,
    mode ? "home",
    owner ? "root",
    group ? "root",
    permissions ? "0644",
  }:
    mkMerge {
      inherit name target mode force owner group permissions;
      patchContent = builtins.toJSON settings;
      mergeCmdStr = ''${pkgs.yq-go}/bin/yq -i -o json -P --indent 2 ". *= load(\"$PATCH\")" "$TARGET"'';
      emptyInit = "{}";
    };

  mkMergedIni = {
    name,
    target,
    settings,
    force ? false,
    mode ? "home",
    owner ? "root",
    group ? "root",
    permissions ? "0644",
  }:
    mkMerge {
      inherit name target mode force owner group permissions;
      patchContent = lib.generators.toINI {} settings;
      mergeCmdStr = ''${pkgs.crudini}/bin/crudini --merge "$TARGET" < "$PATCH"'';
      emptyInit = "";
    };
in {
  inherit mkMergedYaml mkMergedJson mkMergedIni;
}
