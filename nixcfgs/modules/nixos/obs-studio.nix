{ pkgs, ... }:
{
  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
  };
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=2 card_label="OBS Virtual Camera" exclusive_caps=1
  '';
}
