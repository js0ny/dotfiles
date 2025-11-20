{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    shellWrapperName = "y";
    plugins = {
      git = pkgs.yaziPlugins.git;
      starship = pkgs.yaziPlugins.starship;
    };
    settings = {
      preview.wrap = "yes";
      mgr = {
        show_hidden = true;
        linemode = "size_and_mtime";
      };
      plugin.prepend_fetchers = [
        {
          id = "git";
          name = "*";
          run = "git";
        }
        {
          id = "git";
          name = "*/";
          run = "git";
        }
      ];
    };
    keymap = {
      mgr.prepend_keymap = [
        {
          on = "K";
          run = "seek -5";
          desc = "Seek up 5 units in the preview";
        }
        {
          on = "J";
          run = "seek 5";
          desc = "Seek down 5 units in the preview";
        }

        # Find
        {
          on = ["g" "p"];
          run = "cd ~/Pictures";
          desc = "Go ~/Pictures/";
        }
      ];
    };
    initLua = ''
      function Linemode:size_and_mtime()
      	local time = math.floor(self._file.cha.mtime or 0)
      	if time == 0 then
      		time = ""
      	elseif os.date("%Y", time) == os.date("%Y") then
      		time = os.date("%m-%d %H:%M", time)
      	else
      		time = os.date("%Y-%m-%d", time)
      	end

      	local size = self._file:size()
      	return string.format("%s %s", size and ya.readable_size(size) or "/", time)
      end

      -- Plugin setups
      require("starship"):setup()
      require("git"):setup()
    '';
  };
}
