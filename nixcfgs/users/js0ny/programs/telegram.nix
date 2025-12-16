{
  pkgs,
  lib,
  ...
}: let
  shortcuts = builtins.toJSON [
    {
      command = "previous_chat";
      keys = "alt+k";
    }
    {
      command = "next_chat";
      keys = "alt+j";
    }
    {
      command = "self_chat";
      keys = "alt+0";
    }
    {
      command = "pinned_chat1";
      keys = "alt+1";
    }
    {
      command = "all_chats";
      keys = "alt+1";
    }
    {
      command = "pinned_chat2";
      keys = "alt+2";
    }
    {
      command = "folder1";
      keys = "alt+2";
    }
    {
      command = "pinned_chat3";
      keys = "alt+3";
    }
    {
      command = "folder2";
      keys = "alt+3";
    }
    {
      command = "pinned_chat4";
      keys = "alt+4";
    }
    {
      command = "folder3";
      keys = "alt+4";
    }
    {
      command = "pinned_chat5";
      keys = "alt+5";
    }
    {
      command = "folder4";
      keys = "alt+5";
    }
    {
      command = "pinned_chat6";
      keys = "alt+6";
    }
    {
      command = "folder5";
      keys = "alt+6";
    }
    {
      command = "pinned_chat7";
      keys = "alt+7";
    }
    {
      command = "folder6";
      keys = "alt+7";
    }
    {
      command = "pinned_chat8";
      keys = "alt+8";
    }
    {
      command = "last_folder";
      keys = "alt+8";
    }
    {
      command = "show_archive";
      keys = "alt+9";
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
}
