{pkgs, ...}: let
  nvimAlias = {"v" = "nvim";};
in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      lua5_1
      lua51Packages.luarocks
      # image support
      pkg-config
      imagemagick
    ];
  };
  programs.fish.shellAbbrs = nvimAlias;
  programs.bash.shellAliases = nvimAlias;
  programs.zsh.shellAliases = nvimAlias;
  programs.nushell.shellAliases = nvimAlias;
}
