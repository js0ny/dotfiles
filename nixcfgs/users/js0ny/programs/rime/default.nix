{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./dicts.nix
    ./squirrel.nix
    ./fcitx.nix
  ];
  home.activation.deployRime =
    if pkgs.stdenv.isDarwin
    then
      lib.hm.dag.entryAfter ["writeBoundary"] ''
        /Library/Input\ Methods/Squirrel.app/Contents/MacOS/Squirrel --reload
      ''
    else
      # TODO: Buggy
      lib.hm.dag.entryAfter ["writeBoundary"] ''
        # ${pkgs.kdePackages.qttools}/bin/qdbus org.fcitx.Fcitx5 /controller org.fcitx.Fcitx.Controller1.SetConfig "fcitx://config/addon/rime/deploy" ""
      '';
}
