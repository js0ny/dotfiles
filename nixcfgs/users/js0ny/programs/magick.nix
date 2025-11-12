{pkgs, ...}: {
  home.packages = [pkgs.imagemagick];
  home.file.".local/share/kio/servicemenus/image-format.desktop" = {
    enable = true;
    executable = true;
    text = ''
      [Desktop Entry]
      Type=Service
      MimeType=image/*
      Actions=to-avif;to-webp;to-jpeg
      X-KDE-Submenu=Image Format Conversion
      X-KDE-Submenu[CN]=图像格式转换

      [Desktop Action to-avif]
      Name=Convert to AVIF
      Icon=edit-image
      Exec=magick "%f" "%f.avif"

      [Desktop Action to-webp]
      Name=Convert to WebP
      Icon=edit-image
      Exec=magick "%f" "%f.webp"

      [Desktop Action to-jpeg]
      Name=Convert to JPEG
      Icon=edit-image
      Exec=magick "%f" "%f.jpg"
    '';
  };
}
