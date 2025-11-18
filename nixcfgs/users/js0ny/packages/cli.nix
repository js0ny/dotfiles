# ~/.config/nix-config/common/packages-headless.nix
{pkgs, ...}: {
  home.packages = with pkgs; [
    rclone
    age
    aichat
    beancount
    bat
    btop
    gnumake
    chezmoi
    cmake
    curlie
    duf
    dust
    fd
    ffmpeg
    delta
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
    zsh
    fish
    zoxide
    wakatime-cli
    sdcv
    # Langs
    # lua luajit
    lua51Packages.luarocks
    ghostscript
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
  ];
}
