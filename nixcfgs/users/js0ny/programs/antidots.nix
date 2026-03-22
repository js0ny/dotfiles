#  https://wiki.archlinux.org/title/XDG_Base_Directory
{config, ...}: let
  xdg-data = "${config.xdg.dataHome}";
  xdg-config = "${config.xdg.configHome}";
  xdg-cache = "${config.xdg.cacheHome}";
  xdg-state = "${config.xdg.stateHome}";
  home = "${config.home.homeDirectory}";
  user = "${config.home.username}";
in {
  home.sessionVariables = {
    _JAVA_OPTIONS =
      "-Djava.util.prefs.userRoot='${xdg-config}/java'" # ~/.java/fonts
      + "-Djavafx.cachedir='${xdg-cache}/openjfx'"; # ~/.openjfx
    CARGO_HOME = "${xdg-data}/cargo";
    # Sometimes required under Wayland
    XCOMPOSEFILE = "${xdg-config}/X11/XCompose";
    XCOMPOSECACHE = "${xdg-cache}/X11/XCompose";
    DOCKER_CONFIG = "${xdg-config}/docker";
    GNUPGHOME = "${xdg-data}/gnupg";
    GRADLE_USER_HOME = "${xdg-data}/gradle";
    PASSWORD_STORE_DIR = "${xdg-data}/password-store";
    CODEX_HOME = "${xdg-config}/codex";
    KIVY_HOME = "${xdg-data}/kivy"; # python-kivy ~/.kivy
    LEIN_HOME = "${xdg-data}/lein"; # leiningen ~/.lein ~/.m2
    NPM_CONFIG_USERCONFIG = "${xdg-config}/npm/npmrc";
    NUGET_PACKAGES = "${xdg-data}/nuget/packages";
    OLLAMA_MODELS = "${xdg-data}/ollama/models"; # Only for models aka ~/.ollama/models
    RUSTUP_HOME = "${xdg-data}/rustup";
    W3M_DIR = "${xdg-state}/w3m";
    WAKATIME_HOME = "${xdg-config}/wakatime"; # ~/.wakatime
    WGETRC = "${xdg-config}/wget/wgetrc";
  };
  xdg.configFile."npm/npmrc".text = ''
    prefix=${xdg-data}/npm
    cache=${xdg-cache}/npm
    init-module=${xdg-config}/npm/config/npm-init.js
    logs-dir=${xdg-state}/npm/logs
  '';
  xdg.configFile."wget/wgetrc".text = ''
    hsts-file = ${xdg-state}/wget/wget-hsts
  '';
  systemd.user.tmpfiles.rules = [
    "d ${xdg-config}/wakatime 0700 ${user} users -"
  ];
}
