{...}: let
  # Why using nvim gui:
  #   * when `rga-fzf`: nvim wrapper failed to launch
  #   * nvim wrapper reports error on parsing filename with spaces
  gvim = "neovide.desktop";
  simpleText =
    [
      "text/plain"
      "text/x-csrc" # .c
      "text/x-chdr" # .h
      "text/javascript"
      "text/x-python"
      "application/yaml" # .yaml, .yml
      "text/x-patch" # .patch .diff
      "text/x-devicetree-source" # .dts
      "text/x-nix" # .nix (custom defined below)
      "text/x-pdx-descriptor" # .mod (custom defined below)
    ]
    ++ [
      "text/csv"
      "text/markdown"
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
    "audio/x-vorbis+ogg" # .ogg
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
  video = [
    "video/mp4"
    "video/quicktime" # .mov
    "video/x-matroska" # .mkv
    "video/mp2t" # .ts .mts .m2ts
  ];

  # Image Viewer:
  #     gwenview: keyboard driven, high compatibility
  #     loupe: Performance is incredible
  # NOTE:
  # Gwenview cannot open avif images properly
  # See: https://github.com/NixOS/nixpkgs/issues/351863
  imageViewers = "org.gnome.Loupe.desktop;mpv.desktop;org.kde.gwenview.desktop";
  audioPlayers = "mpv.desktop;org.kde.elisa";
  browsers = "firefox.desktop;chromium-browser.desktop";
  archiveManager = "org.gnome.FileRoller.desktop;org.kde.ark.desktop;peazip.desktop";
  mkAssoc = app: mimes:
    builtins.listToAttrs (map (mime: {
        name = mime;
        value = app;
      })
      mimes);
in {
  xdg.configFile."mimeapps.list".force = true;
  xdg.mime.enable = true;
  xdg.mimeApps = {
    enable = true;
    # In Dolphin, middle click to open with 2nd order default app
    defaultApplications =
      mkAssoc "sioyek.desktop;org.kde.okular;" ["application/pdf"]
      // mkAssoc gvim simpleText
      // {
        # "inode/directory" = "org.kde.dolphin.desktop";
        "inode/directory" = "org.gnome.Nautilus.desktop";
      }
      // mkAssoc imageViewers image
      // mkAssoc "onlyoffice-desktopeditors.desktop" [
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
        "application/vnd.openxmlformats-officedocument.presentationml.presentation"
      ]
      # Audio:
      #     music: elisa: fully featured, good cjk support
      #     audio: mpv: simple and fast
      // mkAssoc audioPlayers audio
      // mkAssoc browsers browser
      // mkAssoc "org.telegram.desktop.desktop" [
        "x-scheme-handler/tg"
        "x-scheme-handler/tonsite"
      ]
      // mkAssoc archiveManager archive
      // mkAssoc "mpv.desktop" video
      // {
        "application/epub+zip" = "com.github.johnfactotum.Foliate.desktop";
        # Loupe does not support dds
        # .dds Microsoft DirectDraw Surface
        "image/x-dds" = "mpv.desktop";
      };
  };
  home.sessionVariables.BROWSER = "firefox";

  xdg.dataFile = {
    "mime/packages/nix.xml".text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
        <mime-type type="text/x-nix">
          <comment>Nix Source Code</comment>
          <glob pattern="*.nix"/>
          <sub-class-of type="text/plain"/>
        </mime-type>
      </mime-info>
    '';
    # Mod descriptor file for Paradox games
    "mime/packages/pdx-mod-descriptor.xml".text = ''
      <?xml version="1.0" encoding="UTF-8"?>
          <mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
            <mime-type type="text/x-pdx-descriptor">
              <comment>Paradox Mod Descriptor</comment>
              <sub-class-of type="text/plain"/>
              <glob pattern="*.mod" weight="80"/> <magic priority="80">
                <match value="name=" type="string" offset="0:200"/>
                <match value="tags=" type="string" offset="0:200"/>
                <match value="version=" type="string" offset="0:200"/>
                <match value="supported_version=" type="string" offset="0:200"/>
              </magic>
            </mime-type>
          </mime-info>
    '';
  };
}
