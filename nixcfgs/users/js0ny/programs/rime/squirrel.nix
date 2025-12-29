{
  lib,
  pkgs,
  ...
}:
lib.mkIf pkgs.stdenv.isDarwin {
  targets.darwin.defaults = {
    "com.apple.inputsources.plist" = {
      "AppleEnabledThirdPartyInputSources" = [
        {
          "Bundle ID" = "im.rime.inputmethod.Squirrel";
          "Input Mode" = "im.rime.inputmethod.Squirrel.Hans";
          "InputSourceKind" = "Input Mode";
        }
        {
          "Bundle ID" = "im.rime.inputmethod.Squirrel";
          "InputSourceKind" = "Keyboard Input Method";
        }
      ];
    };
  };
}
