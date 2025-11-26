{...}: let
  # Why using nvim gui:
  #   * when `rga-fzf`: nvim wrapper failed to launch
  #   * nvim wrapper reports error on parsing filename with spaces
  gvim = "neovide.desktop";
  simpleText = [
    "text/plain"
    "text/x-csrc" # .c
    "text/x-chdr" # .h
    "text/javascript"
    "text/x-python"
    "application/yaml" # .yaml, .yml
  ];
  image = [
    "image/jpeg"
    "image/jpg"
    "image/png"
    "image/gif"
    "image/bmp"
    "image/avif"
    "image/webp"
  ];
  audio = [
    "audio/flac"
    "audio/vnd.wave" # .wav
  ];
  browser = [
    "text/html"
    "x-scheme-handler/http"
    "x-scheme-handler/https"
  ];
  archive = [
    "application/zip"
    "application/x-rar"
    "application/x-7z-compressed"
    "application/x-tar"
    "application/x-zstd-compressed-tar" # .tar.zst
  ];

  # Image Viewer:
  #     gwenview: keyboard driven, high compatibility
  #     loupe: Performance is incredible
  imageViewers = "org.kde.gwenview.desktop;org.gnome.Loupe.desktop";
  audioPlayers = "mpv.desktop;org.kde.elisa";
  browsers = "firefox.desktop;chromium-browser.desktop";
  archiveManager = "org.gnome.FileRoller.desktop;org.kde.ark.desktop;peazip.desktop";
in {
  xdg.configFile."mimeapps.list".force = true;
  xdg.mime.enable = true;
  xdg.mimeApps = {
    enable = true;
    # In Dolphin, middle click to open with 2nd order default app
    defaultApplications = {
      # PDF
      "application/pdf" = "org.kde.okular.desktop";
      # Plain text
      "text/plain" = gvim;
      # Source Code - C
      "text/x-csrc" = gvim; # .c
      "text/x-chdr" = gvim; # .h
      "text/javascript" = gvim;
      "text/x-python" = gvim;
      "application/yaml" = gvim; # .yaml, .yml
      # CSV
      "text/csv" = gvim;
      "text/markdown" = gvim;
      # File Explorer
      "inode/directory" = "org.kde.dolphin.desktop";
      "image/jpeg" = imageViewers;
      "image/jpg" = imageViewers;
      "image/png" = imageViewers;
      "image/gif" = imageViewers;
      "image/bmp" = imageViewers;
      "image/avif" = imageViewers;
      "image/webp" = imageViewers;

      # Audio:
      #     music: elisa: fully featured, good cjk support
      #     audio: mpv: simple and fast
      "audio/flac" = audioPlayers;
      "audio/vnd.wave" = audioPlayers; # .wav

      # Browser
      "text/html" = browsers;
      "x-scheme-handler/http" = browsers;
      "x-scheme-handler/https" = browsers;
      # URL Scheme
      "x-scheme-handler/tg" = "org.telegram.desktop.desktop";
      "x-scheme-handler/tonsite" = "org.telegram.desktop.desktop";

      # Archives
      "application/zip" = archiveManager;
      "application/x-rar" = archiveManager;
      "application/x-7z-compressed" = archiveManager;
      "application/x-tar" = archiveManager;
      "application/x-zstd-compressed-tar" = archiveManager; # .tar.zst
    };
  };
  home.sessionVariables.BROWSER = "firefox";
}
