{
  xdg.configFile."mimeapps.list".force = true;
  xdg.mime.enable = true;
  xdg.mimeApps = {
    enable = true;
    # In Dolphin, middle click to open with 2nd order default app
    defaultApplications = {
      # PDF
      "application/pdf" = "org.kde.okular.desktop";
      # Plain text
      "text/plain" = "nvim-qt.desktop";
      # Source Code - C
      "text/x-csrc" = "nvim-qt.desktop";
      "text/x-chdr" = "nvim-qt.desktop";
      # File Explorer
      "inode/directory" = "org.kde.dolphin.desktop";
      # Image Viewer
      #     loupe: Performance is incredible
      "image/jpeg" = "vimiv.desktop;org.gnome.Loupe.desktop";
      "image/jpg" = "vimiv.desktop;org.gnome.Loupe.desktop";
      "image/png" = "vimiv.desktop;org.gnome.Loupe.desktop";
      "image/gif" = "vimiv.desktop;org.gnome.Loupe.desktop";
      "image/bmp" = "vimiv.desktop;org.gnome.Loupe.desktop";
      "image/webp" = "vimiv.desktop;org.gnome.Loupe.desktop";

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
