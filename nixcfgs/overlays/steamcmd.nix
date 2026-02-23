final: prev: {
  steamcmd = prev.steamcmd.overrideAttrs (
    oldAttrs: let
      url = platform: "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_${platform}.tar.gz";
      srcs = {
        x86_64-darwin = prev.fetchurl {
          url = url "osx";
          hash = "sha256-jswXyJiOWsrcx45jHEhJD3YVDy36ps+Ne0tnsJe9dTs=";
        };
        x86_64-linux = prev.fetchurl {
          url = url "linux";
          hash = "sha256-zr8ARr/QjPRdprwJSuR6o56/QVXl7eQTc7V5uPEHHnw=";
        };
      };
    in {
      src = srcs.${prev.stdenv.hostPlatform.system} or (throw "Unsupported system: ${prev.stdenv.hostPlatform.system}");
    }
  );
}
