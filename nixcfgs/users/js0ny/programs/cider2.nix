{pkgs, ...}: let
  catppuccinCider = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "cider";
    rev = "d336144a63f7dc1510b072cfb94eda1730db45cb";
    sha256 = "sha256-wzlRiGDDmVAqAazhhXAl4LepNY/UyyWdLLQVvkHTTSE=";
  };
  ctp-mocha = pkgs.runCommand "cider-theme-ctp-mocha" {} ''
    cp -r ${catppuccinCider}/themes/ctp-mocha $out

    chmod -R u+w $out

    echo "marketplaceID: 12" >> "$out/theme.yml"
    echo 'version: "25.02"' >> "$out/theme.yml"
  '';
  ciderConfigDir = "sh.cider.genten";
  themeDir = "${ciderConfigDir}/themes";
  pluginDir = "${ciderConfigDir}/plugins";
  ciderThemes = [
    {
      package = ctp-mocha;
      id = 12;
      version = "25.02";
    }
  ];
  plugin-listenBrainz =
    pkgs.runCommand "cider-plugin-listenbrainz" {
      # name = "ListenBrainz-1.1.0.zip";
      nativeBuildInputs = [pkgs.unzip];
      src = pkgs.fetchurl {
        url = "https://api.connect.cider.sh/marketplace/projects/10/versions/1.1.0/download";
        sha256 = "sha256-YelqonGEQVZk4+IQ8YwgfqP93a+enN6XxVktlyBCEZI=";
      };
      recursive = true;
    }
    ''
      mkdir -p $out
      unzip $src -d $out
      chmod -R u+w $out
    '';
in {
  home.packages = [pkgs.cider-2];
  xdg.configFile."${themeDir}/12".source = ctp-mocha;
  xdg.configFile."${pluginDir}/ch.kaifa.listenbrainz".source = plugin-listenBrainz;
}
