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
      chezmoi
      curlie
      duf
      dust
      ncdu
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
      ddgr
      jujutsu
      github-copilot-cli
      asciinema
      ansi2html
      unar
      trash-cli
      aria2
      gocryptfs
      uv
    ]
    ++ (
      if pkgs.stdenv.isDarwin
      then with pkgs; [duti]
      else
        with pkgs; [
          bluetui
          steam-run
        ]
    );

  programs.nix-index.enable = true;
  programs.nix-index.symlinkToCacheHome = true;
  programs.nix-index-database.comma.enable = true;
}
