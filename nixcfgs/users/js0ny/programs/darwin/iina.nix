{...}: {
  targets.darwin.defaults = {
    "com.colliderli.iina" = {
      ### General
      # 0: Show welcome window
      # 1: Show open file panel
      # 2: Do Nothing
      actionAfterLaunch = 0;
      # Quit after all windows are closed
      quitWhenNoOpenedWindow = 1;
      # DONT Keep window open after playback finished
      keepOpenOnFileEnd = 0;
      # DONT Remember File History
      iinaLastPlayedFilePath = "";
      recordPlaybackHistory = 0;
      recordRecentFiles = 0;
      # DONT Check Update and DONT Auto Update
      SUAutomaticallyUpdate = 0;
      SUEnableAutomaticChecks = 0;
      receiveBetaUpdate = 0;
      screenshotCopyToClipboard = 1;

      ### UI
      # Not Specified: Dark
      # 2: Light
      # 4: Match System Appearance *
      themeMaterial = 4;
      # Use left/right button for:
      # 0: Speed (Default) - 神人逻辑按一下 》 变成 ×2 再按 《 变成 ×0.5
      # 1: Previous / Next Media
      # 2: Fast Forward / Rewind
      arrowBtnAction = 2;
      # Show chapter position in progress bar
      showChapterPos = 1;
      # Show remaining time instead of total duration
      showRemainingTime = 1;
      ## On Screen Display
      # Supress OSD for:
      # * File Start
      disableOSDFileStartMsg = 1;
      # * Pause / Resume
      disableOSDPauseResumeMsgs = 1;
      ## Thumbnail Preview
      # Enable thumbnail preview > Include files on a mounted remote drive
      enableThumbnailForRemoteFiles = 1;
      # Maximum cache size, unit MB (default: 500)
      maxThumbnailPreviewCacheSize = 100;
      # When entering Picture-in-Picture:
      # 0: Do nothing
      # 1: Hide
      # 2: Minimise
      windowBehaviorWhenPip = 1;

      ### Control
      # Force Touch to:
      # 0: None
      # 1: Toggle fullscreen
      # 2: Pause / Resume
      # 3: Hide OSC
      forceTouchAction = 2;
      # Accepts first mouse click when not focused
      videoViewAcceptsFirstMouse = 1;
      ### Key Bindings
      currentInputConfigName = "vim"; # See below for input config
      ### Advanced
      enableAdvancedSettings = 0;
    };
  };
  # See ../mpv.nix
  # Since iina will build the keybindings from scratch (instead of override mpv's), more keybindings should be added manually
  # this can also interact with iina's api
  home.file."Library/Application Support/com.colliderli.iina/input_conf/vim.conf" = {
    force = true;
    text = ''
      H seek -30
      J add volume -15
      K add volume 15
      L seek 30
      S screenshot video
      f cycle fullscreen
      h seek -5
      j add volume -5
      k add volume 5
      l seek 5
      n playlist-next
      p playlist-prev
      s screenshot
      #@iina o open-file
      SPACE cycle pause
    '';
  };
}
