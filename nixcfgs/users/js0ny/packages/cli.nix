# ~/.config/nix-config/common/packages-headless.nix
{ pkgs, ... }:
{
  home.packages = with pkgs; [
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
    # Langs
    # lua
    luajit
    lua51Packages.luarocks
    ghostscript
    mermaid-cli
    tectonic
    # Misc
    ta-lib
    ddgr
    protonvpn-cli
  ];
}
