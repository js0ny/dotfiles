{...}: let
  # Why using nvim gui:
  #   * when `rga-fzf`: nvim wrapper failed to launch
  #   * nvim wrapper reports error on parsing filename with spaces
  gvim = "nvim-qt.desktop";
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
      # CSV
      "text/csv" = gvim;
      # File Explorer
      "inode/directory" = "org.kde.dolphin.desktop";
      # Image Viewer:
      #     gwenview: keyboard driven, high compatibility
      #     loupe: Performance is incredible
      "image/jpeg" = "org.kde.gwenview.desktop;org.gnome.Loupe.desktop";
      "image/jpg" = "org.kde.gwenview.desktop;org.gnome.Loupe.desktop";
      "image/png" = "org.kde.gwenview.desktop;org.gnome.Loupe.desktop";
      "image/gif" = "org.kde.gwenview.desktop;org.gnome.Loupe.desktop";
      "image/bmp" = "org.kde.gwenview.desktop;org.gnome.Loupe.desktop";
      "image/avif" = "org.kde.gwenview.desktop;org.gnome.Loupe.desktop";
      "image/webp" = "org.kde.gwenview.desktop;org.gnome.Loupe.desktop";

      # Audio:
      #     music: elisa: fully featured, good cjk support
      #     audio: mpv: simple and fast
      "audio/flac" = "mpv.desktop;org.kde.elisa";
      "audio/vnd.wave" = "mpv.desktop;org.kde.elisa"; # .wav

      # Browser
      "text/html" = "firefox.desktop;chromium-browser.desktop";
      "x-scheme-handler/http" = "firefox.desktop;chromium-browser.desktop";
      "x-scheme-handler/https" = "firefox.desktop;chromium-browser.desktop";
      # URL Scheme
      "x-scheme-handler/tg" = "org.telegram.desktop.desktop";
      "x-scheme-handler/tonsite" = "org.telegram.desktop.desktop";
    };
  };
  home.sessionVariables.BROWSER = "firefox";
}
