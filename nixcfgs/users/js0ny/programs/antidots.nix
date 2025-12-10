{config, ...}: let
  xdg-data = "${config.xdg.dataHome}";
  xdg-config = "${config.xdg.configHome}";
  xdg-cache = "${config.xdg.cacheHome}";
in {
  home.sessionVariables = {
    CARGO_HOME = "${xdg-data}/cargo";
    XCOMPOSECACHE = "${xdg-cache}/X11/xcompose";
    DOCKER_CONFIG = "${xdg-config}/docker";
    GNUPGHOME = "${xdg-data}/gnupg";
    GRADLE_USER_HOME = "${xdg-data}/gradle";
    _JAVA_OPTIONS = "-Djava.util.prefs.userRoot='${xdg-data}/java'";
  };
}
