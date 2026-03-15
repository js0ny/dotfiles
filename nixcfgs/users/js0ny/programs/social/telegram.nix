{
  pkgs,
  lib,
  ...
}: let
  mod =
    if pkgs.stdenv.isDarwin
    then "meta"
    else "alt";
  shortcuts = builtins.toJSON [
    {
      command = "previous_chat";
      keys = "${mod}+k";
    }
    {
      command = "next_chat";
      keys = "${mod}+j";
    }
    {
      command = "self_chat";
      keys = "${mod}+0";
    }
    {
      command = "pinned_chat1";
      keys = "${mod}+1";
    }
    {
      command = "all_chats";
      keys = "${mod}+1";
    }
    {
      command = "pinned_chat2";
      keys = "${mod}+2";
    }
    {
      command = "folder1";
      keys = "${mod}+2";
    }
    {
      command = "pinned_chat3";
      keys = "${mod}+3";
    }
    {
      command = "folder2";
      keys = "${mod}+3";
    }
    {
      command = "pinned_chat4";
      keys = "${mod}+4";
    }
    {
      command = "folder3";
      keys = "${mod}+4";
    }
    {
      command = "pinned_chat5";
      keys = "${mod}+5";
    }
    {
      command = "folder4";
      keys = "${mod}+5";
    }
    {
      command = "pinned_chat6";
      keys = "${mod}+6";
    }
    {
      command = "folder5";
      keys = "${mod}+6";
    }
    {
      command = "pinned_chat7";
      keys = "${mod}+7";
    }
    {
      command = "folder6";
      keys = "${mod}+7";
    }
    {
      command = "pinned_chat8";
      keys = "${mod}+8";
    }
    {
      command = "last_folder";
      keys = "${mod}+8";
    }
    {
      command = "show_archive";
      keys = "${mod}+9";
    }
  ];
in {
  home.packages = with pkgs; [
    ayugram-desktop
    materialgram
  ];
  xdg.dataFile = {
    "AyuGramDesktop/tdata/shortcuts-custom.json".text = shortcuts;
    "materialgram/tdata/shortcuts-custom.json".text = shortcuts;
    "TelegramDesktop/tdata/shortcuts-custom.json".text = shortcuts;
  };
  home.file =
    if pkgs.stdenv.isDarwin
    then {
      "Library/Application Support/Telegram Desktop/tdata/shortcuts-custom.json".text = shortcuts;
    }
    else {};
}
