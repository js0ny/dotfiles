{
  pkgs,
  config,
  lib,
  ...
}: let
  aliasCfg = import ./aliases.nix {inherit pkgs config lib;};
in {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      function __last_history_item; echo $history[1]; end
      abbr -a !! --position anywhere --function __last_history_item
      function tv
          touch $argv[1] && $EDITOR $argv[1]
      end
      ${aliasCfg.fishFx}

      fish_vi_key_bindings

      bind -M default ctrl-p up-or-search
      bind -M default ctrl-n down-or-search
      bind -M default ctrl-f forward-char
      bind -M default ctrl-b backward-char
      bind -M default ctrl-a beginning-of-line
      bind -M default ctrl-e end-of-line
      bind -M default ctrl-k kill-line

      bind -M insert ctrl-p up-or-search
      bind -M insert ctrl-n down-or-search
      bind -M insert ctrl-f forward-char
      bind -M insert ctrl-b backward-char
      bind -M insert ctrl-a beginning-of-line
      bind -M insert ctrl-e end-of-line
      bind -M insert ctrl-k kill-line
      bind -M insert ctrl-w backward-kill-path-component

      if [ $TERM_PROGRAM = "konsole" ]
          bind -M insert ctrl-h backward-kill-word
      end


      # ctrl + backspace
      bind -M insert ctrl-backspace backward-kill-path-component
      # alt + backspace
      bind -M insert alt-backspace backward-kill-line
      # ctrl + delete
      bind -M insert ctrl-delete kill-word
      # alt + delete (d$)
      bind -M insert alt-delete kill-line
    '';
    # preferAbbrs = true;
    shellAbbrs =
      aliasCfg.aliases
      // {
        l = "ls -lah";
      };
  };
  programs.zed-editor.extensions = ["fish"];
}
