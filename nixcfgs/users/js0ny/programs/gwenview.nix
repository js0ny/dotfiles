{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs.kdePackages; [
    gwenview
  ];
  xdg.configFile."gwenviewrc-override".text = lib.generators.toINI {} {
    ImageView = {
      AnimationMethod = "DocumentView::NoAnimation";
      MouseWheelBehavior = "MouseWheelBehavior::Browse";
      NavigationEndNotification = "NavigationEndNotification::AlwaysWarn";
    };
  };

  # Manually merge gwenview config to existing file
  home.activation.mergeGwenviewrc = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ -f ~/.config/gwenviewrc-override ]; then
      # Create gwenviewrc if it doesn't exist
      touch ~/.config/gwenviewrc

      # Merge the override file into the main config
      ${pkgs.crudini}/bin/crudini --merge ~/.config/gwenviewrc < ~/.config/gwenviewrc-override

      $DRY_RUN_CMD rm -f ~/.config/gwenviewrc-override
    fi
  '';
}
