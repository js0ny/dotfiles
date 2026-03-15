{...}: {
  programs.chromium = {
    enable = true;
    commandLineArgs = [
      # Done by NIXOS_OZONE_WL=1
      # "--enable-wayland-ime"
      # "--enable-features=WaylandWindowDecorations"
      # "--enable-features=UseOzonePlatform"
      # "--ozone-platform-hint=auto"
      # See: https://wiki.archlinux.org/title/Chromium#Touchpad_gestures_for_navigation
      "--enable-features=TouchpadOverscrollHistoryNavigation"
    ];
    extensions = [
      {id = "logpjaacgmcbpdkdchjiaagddngobkck";} # Shrotkeys
      {id = "bggfcpfjbdkhfhfmkjpbhnkhnpjjeomc";} # Material Icons for GitHub
      {id = "ddkjiahejlhfcafbddmgiahcphecmpfh";} # uBlock Origin Lite
      {id = "ghmbeldphafepmbegfdlkpapadhbakde";} # proton pass
      {id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";} # dark reader
      {id = "gfbliohnnapiefjpjlpjnehglfpaknnc";} # surfingkeys
      {id = "dhdgffkkebhmkfjojejmpbldmpobfkfo";} # tampermonkey
      {id = "jlgkpaicikihijadgifklkbpdajbkhjo";} # CrxMouse: Mouse Gestures
      {id = "mnjggcdmjocbbbhaepdhchncahnbgone";} # SponsorBlock for Youtube
      {id = "clngdbkpkpeebahjckkjfobafhncgmne";} # Stylus
      {id = "jpbjcnkcffbooppibceonlgknpkniiff";} # Global Speed
      {id = "bdiifdefkgmcblbcghdlonllpjhhjgof";} # Kiss Translator
      {id = "gebbhagfogifgggkldgodflihgfeippi";} # Return YouTube Dislike
    ];
  };
}
