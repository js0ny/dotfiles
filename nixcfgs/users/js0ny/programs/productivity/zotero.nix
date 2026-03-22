{
  config,
  pkgs,
  ...
}: let
  profile = "js0ny";
in {
  home.packages = with pkgs; [zotero];
  home.file = {
    ".zotero/profiles.ini".text = ''
      [General]
      StartWithLastProfile=1
      Version=2

      [Profile0]
      Default=1
      IsRelative=1
      Name=${profile}
      Path=${profile}
    '';
    # Antidots
    ".zotero/${profile}/user.js".text = ''
      user_pref("extensions.zotero.dataDir", "${config.home.homeDirectory}/.local/share/Zotero");
      user_pref("extensions.zotero.export.quickCopy.setting", "bibliography=http://www.zotero.org/styles/ieee");
      user_pref("intl.locale.requested", "zh-CN");
    '';
  };
}
