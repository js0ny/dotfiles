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
      "image/jpeg" = "nsxiv.desktop;org.gnome.Loupe.desktop";
      "image/jpg" = "nsxiv.desktop;org.gnome.Loupe.desktop";
      "image/png" = "nsxiv.desktop;org.gnome.Loupe.desktop";
      "image/gif" = "nsxiv.desktop;org.gnome.Loupe.desktop";
      "image/bmp" = "nsxiv.desktop;org.gnome.Loupe.desktop";
      "image/webp" = "nsxiv.desktop;org.gnome.Loupe.desktop";
      # Browser
      "text/html" = "firefox.desktop;chromium-browser.desktop";
      "x-scheme-handler/http" = "firefox.desktop;chromium-browser.desktop";
      "x-scheme-handler/httpss" = "firefox.desktop;chromium-browser.desktop";
      # URL Scheme
      "x-scheme-handler/tg" = "org.telegram.desktop.desktop";
      "x-scheme-handler/tonsite" = "org.telegram.desktop.desktop";
    };
  };
}
