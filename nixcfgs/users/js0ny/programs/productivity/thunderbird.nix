{...}: {
  programs.thunderbird = {
    enable = true;
    profiles.js0ny = {
      isDefault = true;
    };
  };
  catppuccin.thunderbird.profile = "js0ny";
}
