{pkgs, ...}: {
  home.packages = with pkgs; [
    protontricks
    bottles
  ];
  dconf.settings = {
    "com/usebottles/bottles" = {
      update-date = true;
      steam-proton-support = true;
      startup-view = "page_library";
    };
  };
}
