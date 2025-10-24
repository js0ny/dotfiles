{
  config,
  pkgs,
  ...
}: {
  # Managed by Determinate
  nix.enable = false;
  system.stateVersion = 6;
  system.primaryUser = "js0ny";
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    age
    aichat
    bat
    btop
    cmake
    coreutils
    curlie
    dos2unix
    duf
    dust
    duti
    fastfetch
    fd
    ffmpeg
    fish
    fzf
    delta
    glow
    go
    hyperfine
    imagemagick
    just
    lazygit
    less
    lsd
    neovim
    nushell
    pandoc
    procs
    pnpm
    ripgrep
    ripgrep-all
    starship
    tlrc
    tmux
    uv
    yazi
    zoxide
  ];

  programs.zsh.enable = true;
}
