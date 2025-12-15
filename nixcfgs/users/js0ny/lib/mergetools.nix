{
  config,
  lib,
  pkgs,
  ...
}: let
  mkMergedYaml = {
    name, # This value should be unique for each merged YAML config
    target, # The target YAML file path relative to $HOME
    settings, # The Nix Settings to convert to YAML and merge
  }: let
    yamlContent = lib.generators.toYAML {} settings;

    # This file will hold the Nix-managed YAML content
    # symlink to /nix/store/***.nix-managed for clarity
    patchFile = "${target}.nix-managed";
  in {
    # Write the Nix-managed YAML content for merging and preservation
    home.file."${patchFile}".text = yamlContent;

    home.activation."merge-${name}" = lib.hm.dag.entryAfter ["writeBoundary"] ''
      TARGET="$HOME/${target}"
      PATCH="$HOME/${patchFile}"

      if [ -f "$PATCH" ]; then
        verboseEcho "Merging Nix managed YAML config into: $TARGET"

        run mkdir -p "$(dirname "$TARGET")"

        if [ ! -f "$TARGET" ]; then
          echo "{}" > "$TARGET"
        fi

        # Arguments:
        # * -i: In-place edit
        # * -oy: Output YAML
        # * -P: Pretty Print (indentation, etc.)
        run ${pkgs.yq-go}/bin/yq -i -oy -P ". *= load(\"$PATCH\")" "$TARGET"
      fi
    '';
  };
in {
  inherit mkMergedYaml;
}
