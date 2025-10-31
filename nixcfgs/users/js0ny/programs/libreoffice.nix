{pkgs, ...}: {
  home.packages = [pkgs.libreoffice];
  home.file.".local/share/kio/servicemenus/office2pdf.desktop" = {
    text = ''
      [Desktop Entry]
      Type=Service
      MimeType=application/vnd.openxmlformats-officedocument.wordprocessingml.document;application/vnd.openxmlformats-officedocument.presentationml.presentation;
      Actions=convertToPDF
      Icon=application-pdf
      X-KDE-Priority=TopLevel
      X-KDE-StartupNotify=false

      [Desktop Action convertToPDF]
      Name=Convert to PDF
      Name[CN]=转换为 PDF
      Icon=application-pdf
      Exec=soffice --headless --convert-to pdf "%f" --outdir .
    '';
  };
}
