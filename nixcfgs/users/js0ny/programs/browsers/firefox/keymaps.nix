# New in Firefox 147
# about:keyboard
{pkgs, ...}: let
  profileDir =
    if pkgs.stdenv.isDarwin
    then "Library/Application Support/Firefox/Profiles"
    else ".mozilla/firefox";
  profileName = "default";
in {
  home.file."${profileDir}/${profileName}/customKeys.json".text = builtins.toJSON {
    key_privatebrowsing = {
      modifiers = "accel,shift";
      key = "N";
    };
    key_undoCloseWindow = {};
    # Sidebery Sidebar
    ext-key-id-_3c078156-979c-498b-8991-85f7987dd929_-sidebar-action = {};
    viewGenaiChatSidebarKb = {};
    key_viewInfo = {};
    key_switchTextDirection = {};
  };
}
