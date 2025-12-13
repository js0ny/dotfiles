{pkgs, ...}: {
  home.packages = with pkgs;
    [
      flac
      mediainfo
      exiftool
      yt-dlp
    ]
    ++ (
      if pkgs.stdenv.isLinux
      then
        with pkgs; [
          picard
        ]
      else []
    );
}
