{...}: {
  programs.nixcord = {
    enable = true;

    # Clients
    discord = {
      enable = true;
      autoscroll.enable = true;
      vencord.enable = true;
    };

    # Plugins
    config = {
      plugins = {
        alwaysAnimate.enable = true;
        alwaysTrust.enable = true;
        ClearURLs.enable = true;
        copyFileContents.enable = true;
        CopyUserURLs.enable = true;
        disableCallIdle.enable = true;
        favoriteEmojiFirst.enable = true;
        forceOwnerCrown.enable = true;
        friendsSince.enable = true;
        noDevtoolsWarning.enable = true;
        readAllNotificationsButton.enable = true;
        serverInfo.enable = true;
        showMeYourName = {
          enable = true;
          includedNames = "{friend, nick} [{display}] (@{user})";
        };
        silentMessageToggle.enable = true;
        silentTyping.enable = true;
        startupTimings.enable = true;
        validReply.enable = true;
        validUser.enable = true;
      };
    };
  };
}
