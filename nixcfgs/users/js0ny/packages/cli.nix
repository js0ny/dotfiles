# ~/.config/nix-config/common/packages-headless.nix
{pkgs, ...}: {
  programs.bat.enable = true;
  programs.btop.enable = true;
  programs.delta.enable = true;
  programs.lazygit = {
    enable = true;
    settings = {
      git.pagers = [{pager = "delta --dark --paging=never";}];
    };
  };

  home.packages = with pkgs;
    [
      rclone
      age
      aichat
      beancount
      gnumake
      chezmoi
      curlie
      duf
      dust
      fd
      ffmpeg
      glow
      hyperfine
      just
      lazygit
      lsd
      pandoc
      dos2unix
      nushell
      procs
      ripgrep
      ripgrep-all
      tlrc
      zoxide
      vim
      wget
      git
      fastfetch
      fzf
      kitty
      zoxide
      wakatime-cli
      sdcv
      # Misc ta-lib ddgr protonvpn-cli
      markdown-oxide
      powershell
      gemini-cli
      codex
      imagemagick
      miniserve
      jq
      srm
      mediainfo
      exiftool
      ddgr # DuckDuckGo CLI
      jujutsu
      github-copilot-cli
      yt-dlp
      asciinema
      ansi2html
      httpie
      gron
      jless
      unar
      trash-cli
    ]
    ++ (
      if pkgs.stdenv.isDarwin
      then with pkgs; [duti]
      else with pkgs; [bluetui]
    );

  programs.nix-index.enable = true;
  programs.nix-index.symlinkToCacheHome = true;
  programs.nix-index-database.comma.enable = true;
}
